# app/mailers/user_mailer.rb

class UserMailer < ApplicationMailer
  default from: "article24x7itsolution@gmail.com"

  def custom_email(email, message, file_paths = [])
    @message = message

    Array(file_paths).each do |path|
      next if path.blank? || !File.exist?(path)

      attachments[File.basename(path)] = File.read(path)
    end

    mail(to: email, subject: "Email with Attachment")
  end
end
