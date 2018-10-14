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
    def fav(uid, user_id)
      fav_point = ActionPoint.fav.point
      total_fav = TwitterAPI.instance.client.user(uid).favorites_count
      activity = Activity.find_by(user_id: user_id, action_id: 1)

      if activity == nil
        Activity.create(user_id: user_id, action_id: 1, yesterday_value: total_fav)
        yesterday_fav = total_fav

        @fav = fav_point * (total_fav - yesterday_fav)
      else
        yesterday_fav = Activity.find_by(user_id: user_id, action_id: 1).yesterday_value
        @fav = fav_point * (total_fav - yesterday_fav)
        activity.latest_value = total_fav
        activity.save
      end
      @fav
    end

    def retweet(uid)
      retweet_count = TwitterAPI.instance.client.retweeted_by_user(user_id: uid, count: 10).select { |tweet| tweet.created_at > Time.now.beginning_of_day }.count
      retweet_point = ActionPoint.retweet.point
      @retweet = retweet_point * retweet_count
    end

    def quote(uid)
      quote = []

      TwitterAPI.instance.client.user_timeline(user_id: uid, count: 10).select {|tweet| tweet.created_at > Time.now.beginning_of_day}.each do |tweet|
        if tweet.quote?
          quote << tweet
        end
      end
      quote_count = quote.count
      quote_point = ActionPoint.quote.point
      @quote = quote_point * quote_count
    end

    def reply(uid)
      reply_count = TwitterAPI.instance.client.user_timeline(user_id: uid, count: 50).select {|tweet| tweet.created_at > Time.now.beginning_of_day}.count - TwitterAPI.instance.client.user_timeline(uid, options = { count: 1000, exclude_replies: true }).select {|tweet| tweet.created_at > Time.now.beginning_of_day}.count
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
      TwitterAPI.instance.client.user_timeline(user_id: uid, count: 50, exclude_replies: true, include_rts: false).select {|tweet| tweet.created_at > Time.now.beginning_of_day}.each do |tweet|
        unless tweet.quote?
          if tweet.text.length.between?(1, 14)
            xs_tweet_count += 1
          elsif tweet.text.length.between?(15, 49)
            s_tweet_count += 1
          elsif tweet.text.length.between?(50, 99)
            l_tweet_count += 1
          elsif tweet.text.length.between?(100, 140)
            xl_tweet_count +=1
          end
        end
      end
      @xs_tweet = xs_tweet_count * xs_tweet_point
      @s_tweet = s_tweet_count * s_tweet_point
      @l_tweet = l_tweet_count * l_tweet_point
      @xl_tweet = xl_tweet_count * xl_tweet_point

      @tweet = @xs_tweet + @s_tweet + @l_tweet + @xl_tweet
    end
  end
end
