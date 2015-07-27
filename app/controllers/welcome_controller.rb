class WelcomeController < ApplicationController
  skip_before_action :authenticate_user!

  def locale
    session[:locale] = params[:lang]
    render nothing: true
  end

end
