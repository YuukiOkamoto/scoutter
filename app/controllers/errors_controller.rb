class ErrorsController < ApplicationController
  skip_before_action :require_login
  def twitter_server
  end
end
