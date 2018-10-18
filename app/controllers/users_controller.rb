class UsersController < ApplicationController

  before_action :not_self_page, only: :show
  PATH_TO_PHANTOM_SCRIPT = Rails.root.join('app', 'assets', 'javascripts', 'screenshot.js')

  def show
    @url = request.url
    @data_30days = PowerLevel.get_target_period_array(30, params[:id])
  end

  # ボタン押下時にスクショを取るアクション
  def take_screenshot
    binding.pry
    # public/images配下に画像を保存するようにディレクトリを変更
    Dir.chdir(Rails.root.join('public', 'images'))
    # phantomjs用のスクリプトをsystemコマンドとして実行
    # 最初の引数はスクリーンキャップスクリプトへのパス
    # 2番目の引数はスクリーンキャップを取りたいサイト
    # 3番目の引数は作成して保存するスクリーンキャップファイルの名前
    system "phantomjs #{PATH_TO_PHANTOM_SCRIPT} #{params[:url]} #{params[:url]}.png"
    redirect_to("https://twitter.com/share?ref_src=twsrc%5Etfw")

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
      redirect_to root_path if current_user&.id != params[:id].to_i
    end
end
