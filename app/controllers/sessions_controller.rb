class SessionsController < ApplicationController
  
  def new
    
  end
  
  def create
    auth = request.env["omniauth.auth"]
    user = User.find_by_provider_and_uid(auth["provider"], auth["uid"])
    if(user.nil?)
      user =  User.create_with_omniauth(auth)
    else
      user.update_with_omniauth(auth)
      user.save()
    end
    session[:user_id] = user.id  
    session[:omniauth] = auth.except("extra")
    if(session[:return_to].nil?)
      session[:return_to] = root_url
    end
    redirect_to session[:return_to], :notice => "Signed in!"
    session[:return_to] = nil
  end
  
  def destroy
    session[:user_id] = nil
    redirect_to root_url, :notice => "Signed out!"
  end
end
