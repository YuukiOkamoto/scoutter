require 'twitter'
require 'singleton'

class TwitterAPI
  include Singleton

  attr_reader :client

  def initialize
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
      config.access_token = ENV['ACCESS_TOKEN']
      config.access_token_secret = ENV['ACCESS_TOKEN_SECRET']
    end
  end

  class << self
    def fav(uid, user)
      fav_point = ActionPoint.fav.point
      total_fav = TwitterAPI.instance.client.user(uid).favorites_count
      activity = Activity.find_by(user_id: user.id, action_id: 1)

      if activity == nil
        Activity.create(user_id: user.id, action_id: 1, yesterday_value: total_fav)
        yesterday_fav = total_fav

        @fav = fav_point * (total_fav - yesterday_fav)
      else
        yesterday_fav = Activity.find_by(user_id: user.id, action_id: 1).yesterday_value
        fav_count = total_fav - yesterday_fav
        if fav_count > Action.fav.limit
          fav_count = Action.fav.limit
        end
        @fav = fav_point * fav_count
        activity.latest_value = total_fav
        activity.save
      end
      @fav
    end

    def retweet(uid)
      retweet_count = TwitterAPI.instance.client.retweeted_by_user(user_id: uid, count: Action.retweet.limit).select { |tweet| tweet.created_at > Time.now.beginning_of_day }.count
      retweet_point = ActionPoint.retweet.point
      @retweet = retweet_point * retweet_count
    end

    def quote(uid)
      quote = []

      TwitterAPI.instance.client.user_timeline(user_id: uid, count: Action.quote.limit).select { |tweet| tweet.created_at > Time.now.beginning_of_day }.each do |tweet|
        if tweet.quote?
          quote << tweet
        end
      end
      quote_count = quote.count
      quote_point = ActionPoint.quote.point
      @quote = quote_point * quote_count
    end

    def reply(uid)
      reply_count = TwitterAPI.instance.client.user_timeline(user_id: uid, count: Action.reply.limit).select { |tweet| tweet.created_at > Time.now.beginning_of_day }.count - TwitterAPI.instance.client.user_timeline(uid, options = { count: 1000, exclude_replies: true }).select { |tweet| tweet.created_at > Time.now.beginning_of_day }.count
      reply_point = ActionPoint.reply.point
      @reply = reply_count * reply_point
    end

    def tweet(uid)
      xs_tweet_count = 0
      xs_tweet_point = ActionPoint.xs_tweet.point
      s_tweet_count = 0
      s_tweet_point = ActionPoint.s_tweet.point
      l_tweet_count = 0
      l_tweet_point = ActionPoint.l_tweet.point
      xl_tweet_count = 0
      xl_tweet_point = ActionPoint.xl_tweet.point

      xs_tweet_minimum = ActionQuality.xs_tweet.minimum
      s_tweet_minimum = ActionQuality.s_tweet.minimum
      l_tweet_minimum = ActionQuality.l_tweet.minimum
      xl_tweet_minimum = ActionQuality.xl_tweet.minimum
      xs_tweet_maximum = ActionQuality.xs_tweet.maximum
      s_tweet_maximum = ActionQuality.s_tweet.maximum
      l_tweet_maximum = ActionQuality.l_tweet.maximum
      xl_tweet_maximum = ActionQuality.xl_tweet.maximum

      TwitterAPI.instance.client.user_timeline(user_id: uid, count: Action.tweet.limit, exclude_replies: true, include_rts: false).select { |tweet| tweet.created_at > Time.now.beginning_of_day }.each do |tweet|
        unless tweet.quote?
          if tweet.text.length.between?(xs_tweet_minimum, xs_tweet_maximum)
            xs_tweet_count += 1
          elsif tweet.text.length.between?(s_tweet_minimum, s_tweet_maximum)
            s_tweet_count += 1
          elsif tweet.text.length.between?(l_tweet_minimum, l_tweet_maximum)
            l_tweet_count += 1
          elsif tweet.text.length.between?(xl_tweet_minimum, xl_tweet_maximum)
            xl_tweet_count += 1
          end
        end
      end
      @xs_tweet = xs_tweet_count * xs_tweet_point
      @s_tweet = s_tweet_count * s_tweet_point
      @l_tweet = l_tweet_count * l_tweet_point
      @xl_tweet = xl_tweet_count * xl_tweet_point

      @tweet = @xs_tweet + @s_tweet + @l_tweet + @xl_tweet
    end

    def powering(uid, user)
      @daily_score = fav(uid, user) + retweet(uid) + quote(uid) + reply(uid) + tweet(uid)
      @daily_power = @daily_score * Character.find(user.character_id).growth_rate
      @daily_power = @daily_power.to_i

      # デイリー戦闘力をpower_levelsテーブルに保存
      # 今日一度も戦闘力を図っていなければデイリー戦闘力のレコードを作成し、一度でも測っていればデイリー戦闘力を更新する
      @daily_power_record = PowerLevel.where('created_at > ?', Time.now.beginning_of_day).find_by(user_id: user.id)
      if @daily_power_record.nil?
        PowerLevel.create(user_id: user.id, power: @daily_power)
      else
        @daily_power_record.power = @daily_power
        @daily_power_record.save
      end

      # 戦闘力の合計値によって、ユーザーのキャラクターを変更
      @power_levels = PowerLevel.get_total_power(user_id: user.id)
      user.character_id = Character.decide_character_id(@power_levels)
      user.save
    end

    def update_user_info(user, uid)
      if user.name != TwitterAPI.instance.client.user(uid).name
        user.name = TwitterAPI.instance.client.user(uid).name
        user.save
      elsif user.twitter_id != TwitterAPI.instance.client.user(uid).screen_name
        user.twitter_id = TwitterAPI.instance.client.user(uid).screen_name
        user.save
      elsif user.image != TwitterAPI.instance.client.user(uid).profile_image_url_https
        user.image = TwitterAPI.instance.client.user(uid).profile_image_url_https
        user.save
      end
    end
  end
end
