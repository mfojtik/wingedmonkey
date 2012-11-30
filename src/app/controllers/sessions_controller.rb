class SessionsController < ApplicationController
  skip_before_filter :require_provider_authentication

  def new
  end

  def create
    if current_provider.connect(params)
      session[:current_provider_creds] = params
      return_to = session.delete(:return_to) || "/"
      redirect_to return_to, notice: "Logged into #{current_provider.type}"
    else
      flash.now.alert "Invalid cloud credentials"
      render "new"
    end
  end

  def destroy
    session.delete(:current_provider_creds)
  end
end
