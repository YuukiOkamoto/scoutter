require 'twitter'

module TwitterAPI
  extend ActiveSupport::Concern
  
  included do
    attr_reader :client
  end

  def twitter_client
    @client ||= Twitter::REST::Client.new do |config|
      config.consumer_key = ENV['CONSUMER_KEY']
      config.consumer_secret = ENV['CONSUMER_SECRET']
    end
  end

  def private_account?
    twitter_client.user(self.uid).protected?
  end

  def user_name
    twitter_client.user(self.uid).name
  end

  def twitter_id
    twitter_client.user(self.uid).screen_name
  end

  def profile_image
    twitter_client.user(self.uid).profile_image_url_https.to_s.sub('_normal', '')
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
    daily_power_record = self.power_levels.daily.first_or_initialize
    daily_power_record.update_attributes(power: power)
    # sum_powersの日次、週次、累計を保存or更新
    self.sum_powers.bulk_create_or_update
    # 戦闘力の合計値によって、ユーザーのキャラクターを変更
    self.character_id = Character.decide_character_id(self.total_power)
    self.save if self.character_id_changed?
  end

  def get_count(type)
    uid = self.uid
    case type
    when :fav
      twitter_client.user(uid).favorites_count
    when :retweet
      twitter_client.retweeted_by_user(uid, options = { count: @retweet_limit }).select { |tweet| tweet.created_at > Date.today.beginning_of_day }.count
    when :reply
      all_tweet =
        twitter_client.user_timeline(uid, options = { count: 200 })
          .select { |tweet| tweet.created_at > Date.today.beginning_of_day }.count
      exclude_reply_tweet =
        twitter_client.user_timeline(uid, options = { count: 200, exclude_replies: true })
          .select { |tweet| tweet.created_at > Date.today.beginning_of_day }.count
      all_tweet - exclude_reply_tweet
    when :quote
      twitter_client.user_timeline(uid, options = { count: 200, exclude_replies: true, include_rts: false })
        .select { |tweet| tweet.created_at >= Date.today.beginning_of_day && tweet.quote? }.count
    end
  end

  private

    def fav_count_to_score
      activity = self.activities.find_by(action_id: Action.kinds[:fav])
      fav_count = (activity.latest_value - activity.yesterday_value).clamp(0, @fav_limit)
      fav_count * @fav_point
    end

    def retweet_count_to_score
      retweet_count = get_count(:retweet)
      retweet_count * @retweet_point
    end

    def quote_count_to_score
      quote_count = get_count(:quote).clamp(0, @quote_limit)
      quote_count * @quote_point
    end

    def reply_count_to_score
      reply_count = get_count(:reply).clamp(0, @reply_limit)
      reply_count * @reply_point
    end

    def tweet_count_to_score
      xs_tweet_count, s_tweet_count, l_tweet_count, xl_tweet_count = 0, 0, 0, 0
      get_tweet_data.take(@tweet_limit).each do |tweet|
        case tweet.text.length
        when between?(@xs_tweet_minimum, @xs_tweet_maximum)
          xs_tweet_count += 1
        when between?(@s_tweet_minimum, @s_tweet_maximum)
          s_tweet_count += 1
        when between?(@l_tweet_minimum, @l_tweet_maximum)
          l_tweet_count += 1
        when between?(@xl_tweet_minimum, @xl_tweet_maximum)
          xl_tweet_count += 1
        end
      end
      xs_tweet_score = xs_tweet_count * @xs_tweet_point
      s_tweet_score = s_tweet_count * @s_tweet_point
      l_tweet_score = l_tweet_count * @l_tweet_point
      xl_tweet_score = xl_tweet_count * @xl_tweet_point
      xs_tweet_score + s_tweet_score + l_tweet_score + xl_tweet_score
    end

    def get_tweet_data
      twitter_client.user_timeline(self.uid, options = { count: 200, exclude_replies: true, include_rts: false })
        .select { |tweet| tweet.created_at >= Date.today.beginning_of_day && !tweet.quote? }
    end

    def score_to_power(score)
      (score * self.character.growth_rate).round
    end

    def set_data_for_calculation
      @fav_point = Action.fav.first.action_points.first.point
      @retweet_point = Action.retweet.first.action_points.first.point
      @quote_point = Action.quote.first.action_points.first.point
      @reply_point = Action.reply.first.action_points.first.point

      @xs_tweet_point = Action.get_quality(:tweet, :bad).action_point.point
      @s_tweet_point = Action.get_quality(:tweet, :normal).action_point.point
      @l_tweet_point = Action.get_quality(:tweet, :good).action_point.point
      @xl_tweet_point = Action.get_quality(:tweet, :very_good).action_point.point

      @xs_tweet_minimum = Action.get_quality(:tweet, :bad).minimum
      @s_tweet_minimum = Action.get_quality(:tweet, :normal).minimum
      @l_tweet_minimum = Action.get_quality(:tweet, :good).minimum
      @xl_tweet_minimum = Action.get_quality(:tweet, :very_good).minimum

      @xs_tweet_maximum = Action.get_quality(:tweet, :bad).maximum
      @s_tweet_maximum = Action.get_quality(:tweet, :normal).maximum
      @l_tweet_maximum = Action.get_quality(:tweet, :good).maximum
      @xl_tweet_maximum = Action.get_quality(:tweet, :very_good).maximum

      @fav_limit = Action.fav.first.limit
      @retweet_limit = Action.retweet.first.limit
      @quote_limit = Action.quote.first.limit
      @reply_limit = Action.reply.first.limit
      @tweet_limit = Action.tweet.first.limit
    end
end
