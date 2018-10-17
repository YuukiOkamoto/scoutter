class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      @uid = @user.authentications.set_uid(provider)
      TwitterAPI.update_user_info(@user, @uid)
      TwitterAPI.powering(@uid, @user)
      redirect_to user_path(@user.id)
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        @uid = @user.authentications.set_uid(provider)
        if TwitterAPI.instance.client.user(@uid).protected?
          @user.destroy
          redirect_to root_path, danger: '申し訳ありません。非公開アカウントではログインできません。'
          return
        end
        TwitterAPI.powering(@uid, @user)
        redirect_to user_path(@user.id)
      rescue
        logger.debug
        redirect_to root_path
      end
    end
  end
end
