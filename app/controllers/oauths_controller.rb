class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false
  rescue_from Twitter::Error::ServiceUnavailable, with: :render_api_restriction

  def oauth
    login_at(params[:provider])
  end

  def callback
    provider = params[:provider]
    return redirect_to root_path if authentication_reject?
    if @user = login_from(provider)
      @user.refresh_by_twitter

      fav_activity = @user.get_activities_for(:fav)
      fav_activity.create_or_update_for_twitter
      TwitterAPI.powering(@user)
      redirect_to user_path(@user.id)
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
        if TwitterAPI.private_account?(@user)
          return redirect_to root_path, danger: t('.protected')
        end
        fav_activity = @user.get_activities_for(:fav)
        fav_activity.create_or_update_for_twitter
        TwitterAPI.powering(@user)
        redirect_to user_path(@user.id)
      rescue => e
        logger.debug(e)
        redirect_to root_path
      end
    end
  end

  private

    def render_api_restriction
      render 'errors/api_restriction'
    end

    def authentication_reject?
      params[:denied].present?
    end
end
