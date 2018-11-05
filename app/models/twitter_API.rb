require 'twitter'

class TwitterAPI

  attr_reader :client
  attr_accessor :user


  def initialize(user)
    @client = Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
    end
    @user = user
  end

  def private_account?
    @client.user(@user.uid).protected?
  end

  def user_name
    @client.user(@user.uid).name
  end

  def twitter_id
    @client.user(@user.uid).screen_name
  end

  def profile_image
    @client.user(@user.uid).profile_image_url_https.to_s.sub('_normal', '')
  end

  def measure_power
    set_data_for_calculation
    # scoreとpowerを計算
    score = fav_count_to_score +
      retweet_count_to_score +
      quote_count_to_score +
      reply_count_to_score +
      tweet_count_to_score
    power = score_to_power(score)
    # powerをDBに追加or更新
    daily_power_record = @user.power_levels.daily.first_or_initialize
    daily_power_record.update_attributes(power: power)
    # sum_powersの日次、週次、累計を保存or更新
    @user.sum_powers.bulk_create_or_update
    # 戦闘力の合計値によって、ユーザーのキャラクターを変更
    @user.character_id = Character.decide_character_id(@user.total_power)
    @user.save if @user.character_id_changed?
  end

  def get_count(type)
    uid = @user.uid
    case type
    when :fav
      @client.user(uid).favorites_count
    when :retweet
      @client.retweeted_by_user(uid, options = { count: @retweet_limit }).select { |tweet| tweet.created_at > Date.today.beginning_of_day }.count
    when :reply
      @client.user_timeline(uid, options = { count: 200 }).select { |tweet| tweet.created_at > Date.today.beginning_of_day }.count - @client.user_timeline(uid, options = { count: 200, exclude_replies: true }).select { |tweet| tweet.created_at > Date.today.beginning_of_day }.count
    when :tweet
      @client.user_timeline(uid, options = { count: @tweet_limit, exclude_replies: true, include_rts: false }).select { |tweet| tweet.created_at > Date.today.beginning_of_day }
    end
  end

  private

    def fav_count_to_score
      activity = @user.activities.find_by(action_id: Action.kinds[:fav])
      fav_count = (activity.latest_value - activity.yesterday_value).clamp(0, @fav_limit)
      fav_count * @fav_point
    end

    def retweet_count_to_score
      retweet_count = get_count(:retweet)
      retweet_count * @retweet_point
    end

    def quote_count_to_score()
      quote_count = get_count(:tweet).select { |tweet| tweet.quote? }.count.clamp(0, @quote_limit)
      quote_count * @quote_point
    end

    def reply_count_to_score
      reply_count = get_count(:reply).clamp(0, @reply_limit)
      reply_count * @reply_point
    end

    def tweet_count_to_score(xs_tweet_count = 0, s_tweet_count = 0, l_tweet_count = 0, xl_tweet_count = 0)
      get_count(:tweet).each do |tweet|
        unless tweet.quote?
          if tweet.text.length.between?(@xs_tweet_minimum, @xs_tweet_maximum)
            xs_tweet_count += 1
          elsif tweet.text.length.between?(@s_tweet_minimum, @s_tweet_maximum)
            s_tweet_count += 1
          elsif tweet.text.length.between?(@l_tweet_minimum, @l_tweet_maximum)
            l_tweet_count += 1
          elsif tweet.text.length.between?(@xl_tweet_minimum, @xl_tweet_maximum)
            xl_tweet_count += 1
          end
        end
      end
      xs_tweet = @xs_tweet_point * xs_tweet_count
      s_tweet = @s_tweet_point * s_tweet_count
      l_tweet = @l_tweet_point * l_tweet_count
      xl_tweet = @xl_tweet_point * xl_tweet_count

      @tweet = xs_tweet + s_tweet + l_tweet + xl_tweet
    end

    def score_to_power(score)
      (score * @user.character.growth_rate).round
    end

    def set_data_for_calculation
      @fav_point = ActionPoint.fav.point
      @retweet_point = ActionPoint.retweet.point
      @quote_point = ActionPoint.quote.point
      @reply_point = ActionPoint.reply.point

      @xs_tweet_point = ActionPoint.xs_tweet.point
      @s_tweet_point = ActionPoint.s_tweet.point
      @l_tweet_point = ActionPoint.l_tweet.point
      @xl_tweet_point = ActionPoint.xl_tweet.point

      @xs_tweet_minimum = ActionQuality.xs_tweet.minimum
      @s_tweet_minimum = ActionQuality.s_tweet.minimum
      @l_tweet_minimum = ActionQuality.l_tweet.minimum
      @xl_tweet_minimum = ActionQuality.xl_tweet.minimum

      @xs_tweet_maximum = ActionQuality.xs_tweet.maximum
      @s_tweet_maximum = ActionQuality.s_tweet.maximum
      @l_tweet_maximum = ActionQuality.l_tweet.maximum
      @xl_tweet_maximum = ActionQuality.xl_tweet.maximum

      @fav_limit = Action.fav.first.limit
      @retweet_limit = Action.retweet.first.limit
      @quote_limit = Action.quote.first.limit
      @reply_limit = Action.reply.first.limit
      @tweet_limit = Action.tweet.first.limit
    end
end
