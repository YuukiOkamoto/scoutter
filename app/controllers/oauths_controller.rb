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
    else
      begin
        @user = create_from(provider)
        reset_session
        auto_login(@user)
      rescue => e
        logger.debug(e)
      end
    end
    @user.set_access_token_secret(@access_token)
    create_or_update_activities
    @user.measure_power
    redirect_to user_path(@user.id)
  end

  private

    def render_api_restriction
      render 'errors/api_restriction'
    end

    def authentication_reject?
      params[:denied].present?
    end

    def create_or_update_activities
      fav_activity = @user.get_activities_for(:fav)
      fav_activity.create_or_update_for_twitter
    end
end
