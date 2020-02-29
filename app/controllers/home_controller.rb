class HomeController < ApplicationController
  def index
    render plain: "Welcome"
  end
end