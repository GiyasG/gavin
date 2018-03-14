class SessionsController < ApplicationController
  skip_before_action :ensure_login, only: [:new, :create]
  def new
  	# Login Page - new.html.erb
  end

  def create
  	editor = Editor.find_by(name: params[:editor][:name])
  	password = params[:editor][:password]

  	if editor && editor.authenticate(password)
  	  session[:editor_id] = editor.id
      @authority = Authority.first
  	  redirect_to @authority, notice: "Logged in successfully"
  	else
  	  redirect_to editor_path, alert: "Invalid username/password combination"
  	end
  end

  def destroy
  	reset_session # wipe out session and everything in it
    redirect_to authorities_path, notice: "Logged out successfully"
  end
end
