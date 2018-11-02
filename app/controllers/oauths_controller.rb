class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false
  rescue_from Twitter::Error::ServiceUnavailable, with: :render_api_restriction
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    return redirect_to root_path unless params[:denied].nil?
    if @user = login_from(provider)
      @uid = @user.authentications.set_uid(provider)
      TwitterAPI.update_user_info(@user, @uid)
      # 以下、画質向上のため、APIで取得してきたユーザーのプロフィール画像のurlから"_normal"という記述を削除しています。
      @user.image.slice!('_normal')
      TwitterAPI.powering(@uid, @user)
      redirect_to user_path(@user.id)
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        @uid = @user.authentications.set_uid(provider)
        # 以下、画質向上のため、APIで取得してきたユーザーのプロフィール画像のurlから"_normal"という記述を削除しています。
        @user.image.slice!('_normal')
        if TwitterAPI.instance.client.user(@uid).protected?
          @user.destroy
          redirect_to root_path, danger: '申し訳ありません。非公開アカウントではログインできません。'
          return
        end
        TwitterAPI.powering(@uid, @user)
        redirect_to user_path(@user.id)
      rescue => e
        logger.debug(e)
        redirect_to root_path
      end
    end
  end

  protected

  def render_api_restriction
    render 'errors/api_restriction'
  end
end
