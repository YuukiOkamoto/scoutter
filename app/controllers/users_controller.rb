class UsersController < ApplicationController
  require 'uri'

  before_action :not_self_page, only: :show
  before_action :set_period, only: :show

  def show
    @user = User.find(params[:id])
    @data_xxx_days = @user.power_levels.get_per_day_array(@period)
  end

  private

    def not_self_page
      redirect_to root_path if current_user&.id != params[:id].to_i
    end

    def set_period
      @period = Period.days(params[:period])
    end
end
