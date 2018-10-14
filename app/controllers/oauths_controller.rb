class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false
  before_action :set_uid
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      # favのスコア合計値
      @fav = TwitterAPI.fav(@uid, current_user.id)

      # retweetのスコア合計値
      @retweet = TwitterAPI.retweet(@uid)

      #quoteのスコア合計値
      @quote = TwitterAPI.quote(@uid)

      # replyのスコア合計値
      @reply = TwitterAPI.reply(@uid)

      # tweetのスコア合計値
      @tweet = TwitterAPI.tweet(@uid)

      # デイリーの合計スコアを算出し、デイリー戦闘力に換算
      @daily_score = @fav + @retweet + @quote + @reply + @tweet
      @daily_power = @daily_score * Character.find(current_user.character_id).growth_rate
      @daily_power = @daily_power.to_i

      # 1日の最新の戦闘力をpower_levelsテーブルに保存
      # 今日一度も戦闘力を図っていなければ日時の戦闘力を作成し、一度でも測っていれば戦闘力を更新する
      @daily_power_record = PowerLevel.where('created_at > ?', Time.now.beginning_of_day).find_by(user_id: current_user.id)
      if @daily_power_record.nil?
        PowerLevel.create(user_id: current_user.id, power: @daily_power)
      else
        @daily_power_record.power = @daily_power
        @daily_power_record.save
      end

      # 戦闘力の合計値によって、ユーザーのキャラクターを変更
      @power_levels = PowerLevel.get_total_power(current_user.id)
      current_user.character_id = Character.decide_character_id(@power_levels)
      current_user.save

      redirect_to power_levels_path
    else
      begin
        @user = create_from(provider)
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule
        if TwitterAPI.instance.client.user(@uid).protected?
          Authentication.find_by(user_id: @user.id).destroy
          @user.destroy
          redirect_to root_path, danger: '申し訳ありません。非公開アカウントではログインできません。'
          return
        end
        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to power_levels_path
      rescue
        redirect_to root_path
      end
    end
  end

  private

  def set_uid
    @uid = Authentication.find_by(user_id: current_user.id).uid.to_i
  end
end
