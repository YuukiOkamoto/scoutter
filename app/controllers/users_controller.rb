class UsersController < ApplicationController
  def rank
    @rankings = User.power_total_rank.page(params[:page]).per(25)
  end
end
