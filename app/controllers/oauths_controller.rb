class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false
  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      @uid = Authentication.find_by(user_id: current_user.id).uid.to_i
      TwitterAPI.powering(@uid, @user)
      redirect_to power_levels_path
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        @uid = Authentication.find_by(user_id: current_user.id).uid.to_i
        if TwitterAPI.instance.client.user(@uid).protected?
          Authentication.find_by(user_id: @user.id).destroy
          @user.destroy
          redirect_to root_path, danger: '申し訳ありません。非公開アカウントではログインできません。'
          return
        end
        TwitterAPI.powering(@uid, @user)
        redirect_to power_levels_path
      rescue
        redirect_to root_path
      end
    end
  end
end
