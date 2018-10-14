class UsersController < ApplicationController
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

  def show
    @power_levels = PowerLevel.get_total_power(current_user.id)
    @character = Character.find_by(id: current_user.character_id).name
  end
end
