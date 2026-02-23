class SessionsController < ApplicationController
  skip_before_action :require_admin, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by(email: params[:email])

    if user && user.authenticate(params[:password])

      if user.admin?
        session[:user_id] = user.id
        redirect_to root_path, notice: "Welcome Admin"
      else
        flash.now[:alert] = "Access denied. Admin only."
        render :new, status: :unprocessable_entity
      end

    else
      flash.now[:alert] = "Invalid email or password"
      render :new, status: :unprocessable_entity
    end

  end
  def destroy
    reset_session
    redirect_to login_path, notice: "Logged out successfully"
  end
end
