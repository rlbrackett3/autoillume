class SessionsController < ApplicationController
  def new
  end

  def create
    # admin = Admin.find_by_email(params[:email]) || Admin.find_by_username(params[:username])
    # if admin && admin.authenticate(params[:password])
    #   session[:admin_id] = admin.id
    #   redirect_to_target_or_default root_url, :notice => "Logged in!"
    # else
    #   flash.now.alert = "Invalid email or password"
    #   render "new"
    # end
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
