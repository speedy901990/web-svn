class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      session[:user_is_admin] = user.is_admin
      redirect_to root_url, :notice => "Logged in!"
    else
      flash.now.alert = "Invalid email or password"
      render "new"
    end
  end
  
  def destroy
    session[:user_id] = nil
    session[:user_is_admin] = nil
    #flash.now[:notice] = "TEST MESSAGE"
    redirect_to root_url, :notice => "Logged out!"
    
  end
end
