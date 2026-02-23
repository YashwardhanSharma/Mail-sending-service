require "google/cloud/firestore"

class FirebaseService

  def initialize
    @firestore = Google::Cloud::Firestore.new(
      project_id: ENV['FIREBASE_PROJECT_ID'],
      credentials: Rails.root.join(ENV['FIREBASE_CREDENTIALS']).to_s
    )
  end

  def fetch_users
    users_ref = @firestore.col("users")

    users_ref.get.map do |doc|
      {
        id: doc.document_id,
        name: doc[:name],
        email: doc[:email]
      }
    end
  end

  # NEW METHOD
  def create_user(name, email)

    @firestore.col("users").add({
      name: name,
      email: email,
      created_at: Time.current
    })

  end

end
