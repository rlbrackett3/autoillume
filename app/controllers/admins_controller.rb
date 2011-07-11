class AdminsController < ApplicationController
  before_filter :admin_login_required #, :except => [:new, :create]

  # def new
  #   @admin = Admin.new
  # end

  # def create
  #   @admin = Admin.new(params[:admin])
  #   if @admin.save
  #     session[:admin_id] = @admin.id
  #     redirect_to root_url, :notice => "Thank you for signing up! You are now logged in."
  #   else
  #     render :action => 'new'
  #   end
  # end

  def edit
    @admin = current_admin
  end

  def update
    @admin = current_admin
    if @admin.update_attributes(params[:admin])
      redirect_to root_url, :notice => "Your profile has been updated."
    else
      render :action => 'edit'
    end
  end
end
