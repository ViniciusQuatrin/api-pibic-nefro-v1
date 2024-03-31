class PagesController < ApplicationController

  def home
    render json: { message: "Success!" }
  end
end
