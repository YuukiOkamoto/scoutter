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
    # 自分のランキング位置に飛ぶクエリとフラグをつけてリダイレクト
    # renderせずわざわざリダイレクトするのは、URL(/ranking?page○#△)がkaminariのページネーションのURLと似てほしいため。
    # このままrenderすると、/ranking/selfとなってしまう。
    redirect_to ranking_path(view_context.my_rank_query)
  end

  # FIXME：コントローラ内でURLの設定はしたくないので、concerns等の他の場所に退避する
  #        その際に、link_toから戦闘力、キャラ名を受け取るのではなく、直接取得出来るようにすることが望ましい
  def set_share_url
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

    def set_ranks
      case @period = params[:period] || 'total'
      when 'total'
        @users = User.power_rank.total_period
      when 'week'
        @users = User.power_rank.week_period
      when 'day'
        @users = User.power_rank.day_period
      end
      @ranks = @users.page(params[:page]).per(25)
    end
end
