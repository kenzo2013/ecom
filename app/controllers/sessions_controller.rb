class SessionsController < ApplicationController
  def new
  end
  
  def create
    user = User.authenticate(params[:email], params[:password])
    if user
      session[:user_id] = user.id
      redirect_to :controller => "admins", :action => "index"
      flash[:notice] = "Connecté!"
    else
      flash.now.alert = "Email ou password incorrect"
      render "new"
    end
  end
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Déconnecté!"
  end
end
