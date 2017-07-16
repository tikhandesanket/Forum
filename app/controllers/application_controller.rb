class ApplicationController < ActionController::Base

  protect_from_forgery with:  :null_session
  
  def after_sign_in_path_for(resources)
    session[:previous_url] || dashboards_path
  end

  def after_sign_out_path_for(resources)
    new_user_session_path
  end
  
  def authenticate_user!
   unless user_signed_in?
     flash[:danger] = "You must login first"
     redirect_to new_user_session_path
   end
  end
   
end
