class SessionsController < ApplicationController
  def new
  end

  def create
    admin = Admin.authenticate(params[:login], params[:password])
    if admin
      session[:admin_id] = admin.id
      redirect_to_target_or_default root_url, :notice => "Logged in successfully."
    else
      flash.now[:alert] = "Invalid login or password."
      render :action => 'new'
    end
  end

  def destroy
    session[:admin_id] = nil
    redirect_to root_url, :notice => "You have been logged out."
  end
end
