class UsersController < ApplicationController
  require 'open3'
  require 'uri'

  before_action :not_self_page, only: :show
  before_action :set_period, only: :show

  PATH_TO_PHANTOM_SCRIPT = Rails.root.join('app', 'assets', 'javascripts', 'screenshot.js')

  def show
    @data_xxx_days = PowerLevel.get_target_period_array(@period, params[:id])
    @user = User.find(params[:id])
    @url = request.url
    @screenshot_name = @url.gsub(/\//, '¥').concat(".jpg")
  end

  def take_screenshot
    # public/images配下に画像を保存するようにディレクトリを変更
    Dir.chdir(Rails.root.join('app', 'assets', 'images'))
    # phantomjs用のスクリプトをsystemコマンドとして実行
    Open3.capture3("phantomjs #{PATH_TO_PHANTOM_SCRIPT} #{params[:url]} #{params[:file_name]}")
    redirect_to set_share_url
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

  private

  def not_self_page
    # phantomjsからのアクセスを判別し、skipさせる
    return true if params[:access] == 'phantomjs'
    # twitterからのアクセスの場合、topページにリダイレクトさせる
    if params[:accesstype]
      file_name = request.url.gsub(/\//, '¥').gsub(/\?accesstype=tweet/, "").concat(".jpg")
      asset_path = view_context.root_url.concat('assets/', "#{file_name}")
      redirect_to root_path(asset_path: asset_path) && return
    end
    redirect_to root_path if current_user&.id != params[:id].to_i
  end

  def set_share_url
    tweet_url = URI.encode_www_form_component(
    "https://twitter.com/intent/tweet?" +
    "&url=" +
    "#{params[:url]}?accesstype=tweet" +
    "&text=" +
    "テスト"
  )
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
