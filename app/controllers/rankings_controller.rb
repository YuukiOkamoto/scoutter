class RankingsController < ApplicationController
  def index
    @period = params[:period] || 'total'
    @users = User.power_rank.merge_power(@period)
    @ranks = @users.page(params[:page]).per(25)
    redirect_to rankings_path(view_context.my_rank_query) if specify_position?
  end

  private

    def specify_position?
      params[:position].present?
    end
end
