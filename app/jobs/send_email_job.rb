class SendEmailJob < ApplicationJob
  queue_as :default

  def perform(email, message, file_paths = [])
    file_paths ||= []
    file_paths = Array(file_paths).compact   # 👈 remove nil values

    UserMailer.custom_email(email, message, file_paths).deliver_now
  end
end
