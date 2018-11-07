class UsersController < ApplicationController
  require 'uri'

  before_action :not_self_page, only: :show
  before_action :set_period, only: :show

  def show
    @user = User.find(params[:id])
    @data_xxx_days = @user.power_levels.get_per_day_array(@period)
  end

  def rank
    set_ranks
  end

  def my_rank
    set_ranks
    redirect_to ranking_path(view_context.my_rank_query)
  end

  def share_twitter
    tweet_url = URI.encode(
      "http://twitter.com/intent/tweet?" +
        "&text=" +
        "わたしのTwitter戦闘力は…【 #{params[:power]} 】!!!\nこの戦闘力から導き出されたキャラクターは…【 #{params[:character]} 】!!!\n" +
        "毎日測ってTwitter戦闘力を上げていこう!!!\n" +
        "#Scoutter\n#Twitter戦闘力\n" +
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
      @period = Period.days(params[:period])
    end

    def set_ranks
      @period = params[:period] || 'total'
      @users = User.power_rank.merge_power(@period)
      @ranks = @users.page(params[:page]).per(25)
    end
end
