class UsersController < ApplicationController
  require 'uri'

  before_action :not_self_page, only: :show
  before_action :set_period, only: :show

  PATH_TO_PHANTOM_SCRIPT = Rails.root.join('app', 'assets', 'javascripts', 'screenshot.js')

  def show
    @data_xxx_days = PowerLevel.get_target_period_array(@period, params[:id])
    @user = User.find(params[:id])
    @url = request.url
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
    @user = User.find(params[:id])
    tweet_url = URI.encode(
      "http://twitter.com/intent/tweet?" +
      "&hashtags=" +
      "すかうったー" +
      "&text=" +
      "わたしの戦闘力は　＜＜　#{params[:power]}  ＞＞\n\nわたしは　＜＜　#{params[:character]} ＞＞　です！\n\n" +
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
