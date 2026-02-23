# app/controllers/users_controller.rb
class UsersController < ApplicationController
  def index
    @users = FirebaseService.new.fetch_users
  end

  def send_emails
    user_emails = params[:user_emails] || []
    message = params[:message] || "Hello!"
    uploaded_files = params[:attachments] || []

    file_paths = uploaded_files.map do |file|
      path = Rails.root.join("tmp", file.original_filename)
      File.open(path, "wb") { |f| f.write(file.read) }
      path.to_s
    end

    user_emails.each do |email|
      SendEmailJob.perform_later(email, message, file_paths)
    end

    respond_to do |format|
      format.html { redirect_to users_path, notice: "Emails sent with attachments" }
      format.js   # render send_emails.js.erb
    end
  end

  def new_firebase_user
  end

  def create_in_firebase

    name = params[:name]
    email = params[:email]

    if name.blank? || email.blank?
      flash[:alert] = "Name and Email required"
      render :new_firebase_user
      return
    end

    FirebaseService.new.create_user(name, email)

    redirect_to users_path, notice: "User created successfully in Firebase"

  end
end
