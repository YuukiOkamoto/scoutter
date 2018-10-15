class UsersController < ApplicationController
  before_action :not_self_page, only: :show

  def show
    @data_30days = PowerLevel.get_target_period_array(30, params[:id])
    @power_levels = PowerLevel.get_total_power(user_id: current_user.id)
    @character = Character.find_by(id: current_user.character_id).name
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
      redirect_to root_path if current_user&.id != params[:id].to_i
    end
end
