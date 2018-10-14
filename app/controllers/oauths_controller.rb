class OauthsController < ApplicationController
  skip_before_action :require_login, raise: false
  def oauth
    login_at(params[:provider])
  end

  # TODO: 下記アクションのリダイレクト先はログイン動作確認のための仮のパスなので本来の遷移先は戦闘力を表示するページになる予定
  def callback
    provider = params[:provider]
    if @user = login_from(provider)
      redirect_to power_levels_path
    else
      begin
        @user = create_from(provider)
        # NOTE: this is the place to add '@user.activate!' if you are using user_activation submodule
        @uid = Authentication.find_by(user_id: @user.id).uid.to_i
        if TwitterAPI.instance.client.user(@uid).protected?
          Authentication.find_by(user_id: @user.id).destroy
          @user.destroy
          redirect_to root_path, danger: '申し訳ありません。非公開アカウントではログインできません。'
          return
        end
        reset_session # protect from session fixation attack
        auto_login(@user)
        redirect_to power_levels_index_path
      rescue
        redirect_to root_path
      end
    end
  end
end
