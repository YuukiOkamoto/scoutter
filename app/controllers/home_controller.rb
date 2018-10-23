class HomeController < ApplicationController

  def index
    if params[:asset_path]
      @asset_path = params[:asset_path]
    end
  end
end
