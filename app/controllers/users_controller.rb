class UsersController < ApplicationController
  require 'uri'

  before_action :not_self_page, only: :show
  before_action :set_period, only: :show

  def show
    @data_xxx_days = PowerLevel.get_target_period_array(@period, params[:id])
    @user = User.find(params[:id])
  end

  def rank
    case @period = params[:period] || 'total'
    when 'total'
      @ranks = User.power_rank.total_period.page(params[:page]).per(25)
    when 'week'
      @ranks = User.power_rank.week_period.page(params[:page]).per(25)
    when 'day'
      @ranks = User.power_rank.day_period.page(params[:page]).per(25)
    end
  end

  def set_share_url
    tweet_url = URI.encode(
      "http://twitter.com/intent/tweet?" +
      "&text=" +
      "わたしのTwitter戦闘力は・・・【 #{params[:power]} 】!!!\nこの戦闘力から導き出されたキャラクターは・・・【 #{params[:character]} 】!!!\n\n" +
      "毎日測ってTwitter戦闘力を上げていこう!!!\n\n" +
      "#スカウッター\n#あなたのTwitter戦闘力" +
      "&url=" +
      "#{view_context.root_url}"
    )
    redirect_to tweet_url
  end

  private

    def not_self_page
      redirect_to root_path if current_user&.id != params[:id].to_i
    end

    def set_period
      # デフォルトの期間は30日
      @period = case params[:period]
                when 'week' then
                  7
                when 'month' then
                  30
                when 'quarter' then
                  90
                when 'year' then
                  365
                else
                  30
                end
    end
end
