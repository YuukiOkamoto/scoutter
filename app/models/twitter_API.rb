require 'twitter'
require 'singleton'

class TwitterAPI
  include Singleton

  attr_reader :client

  @@fav_point = ActionPoint.fav.point

  @@retweet_point = ActionPoint.retweet.point

  @@quote_point = ActionPoint.quote.point

  @@reply_point = ActionPoint.reply.point

  @@xs_tweet_point = ActionPoint.xs_tweet.point
  @@s_tweet_point = ActionPoint.s_tweet.point
  @@l_tweet_point = ActionPoint.l_tweet.point
  @@xl_tweet_point = ActionPoint.xl_tweet.point

  @@xs_tweet_minimum = ActionQuality.xs_tweet.minimum
  @@s_tweet_minimum = ActionQuality.s_tweet.minimum
  @@l_tweet_minimum = ActionQuality.l_tweet.minimum
  @@xl_tweet_minimum = ActionQuality.xl_tweet.minimum
  @@xs_tweet_maximum = ActionQuality.xs_tweet.maximum
  @@s_tweet_maximum = ActionQuality.s_tweet.maximum
  @@l_tweet_maximum = ActionQuality.l_tweet.maximum
  @@xl_tweet_maximum = ActionQuality.xl_tweet.maximum

  @@fav_limit = Action.fav.first.limit
  @@retweet_limit = Action.retweet.first.limit
  @@quote_limit = Action.quote.first.limit
  @@reply_limit = Action.reply.first.limit
  @@tweet_limit = Action.tweet.first.limit

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
    end
  end

  class << self
    def private_account?(user)
      instance.client.user(user.uid).protected?
    end

    def user_name(user)
      instance.client.user(user.uid).name
    end

    def twitter_id(user)
      instance.client.user(user.uid).screen_name
    end

    def profile_image(user)
      instance.client.user(user.uid).profile_image_url_https.to_s.sub('_normal', '')
    end

    def powering(user)
      # scoreとpowerを計算
      score = fav_count_to_score(user) + retweet(user) + quote(user) + reply(user) + tweet(user)
      power = score_to_power(score, user)
      # powerをDBに追加or更新
      daily_power_record = user.power_levels.daily.first_or_initialize
      daily_power_record.update_attributes(power: power)
      # sum_powersの日次、週次、累計を保存or更新
      user.sum_powers.bulk_create_or_update
      # 戦闘力の合計値によって、ユーザーのキャラクターを変更
      chara_id = Character.decide_character_id(user.total_power)
      user.update(character_id: chara_id) if user.character_id != chara_id
    end

    def fav_count_to_score(user)
      activity = user.activities.find_by(action_id: Action.kinds[:fav])
      fav_count = (activity.latest_value - activity.yesterday_value).clamp(0, @@fav_limit)
      fav_count * @@fav_point
    end

    def retweet(user)
      retweet_count = get_count(user, :retweet)
      @retweet = @@retweet_point * retweet_count
    end

    def quote(user, quote = [])
      get_count(user, :tweet).each { |tweet| quote << tweet if tweet.quote? }
      quote_count = quote.count > @@quote_limit ? @@quote_limit : quote.count
      @quote = @@quote_point * quote_count
    end

    def reply(user)
      reply_count = get_count(user, :reply)
      reply_count = @@reply_limit if reply_count > @@reply_limit
      @reply = @@reply_point * reply_count
    end

    def tweet(user, xs_tweet_count = 0, s_tweet_count = 0, l_tweet_count = 0, xl_tweet_count = 0)
      get_count(user, :tweet).each do |tweet|
        unless tweet.quote?
          if tweet.text.length.between?(@@xs_tweet_minimum, @@xs_tweet_maximum)
            xs_tweet_count += 1
          elsif tweet.text.length.between?(@@s_tweet_minimum, @@s_tweet_maximum)
            s_tweet_count += 1
          elsif tweet.text.length.between?(@@l_tweet_minimum, @@l_tweet_maximum)
            l_tweet_count += 1
          elsif tweet.text.length.between?(@@xl_tweet_minimum, @@xl_tweet_maximum)
            xl_tweet_count += 1
          end
        end
      end
      xs_tweet = @@xs_tweet_point * xs_tweet_count
      s_tweet = @@s_tweet_point * s_tweet_count
      l_tweet = @@l_tweet_point * l_tweet_count
      xl_tweet = @@xl_tweet_point * xl_tweet_count

      @tweet = xs_tweet + s_tweet + l_tweet + xl_tweet
    end

    def score_to_power(score, user)
      (score * user.character.growth_rate).round
    end

    def get_count(user, type)
      uid = user.uid
      case type
      when :fav
        instance.client.user(uid).favorites_count
      when :retweet
        instance.client.retweeted_by_user(uid, options = { count: @@retweet_limit }).select { |tweet| tweet.created_at > Time.now.beginning_of_day }.count
      when :reply
        instance.client.user_timeline(uid, options = { count: 200 }).select { |tweet| tweet.created_at > Time.now.beginning_of_day }.count - TwitterAPI.instance.client.user_timeline(uid, options = { count: 200, exclude_replies: true }).select { |tweet| tweet.created_at > Time.now.beginning_of_day }.count
      when :tweet
        instance.client.user_timeline(uid, options = { count: @@tweet_limit, exclude_replies: true, include_rts: false }).select { |tweet| tweet.created_at > Time.now.beginning_of_day }
      end
    end
  end
end
