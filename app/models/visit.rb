class Visit < ActiveRecord::Base
  validates :shortened_url_id, :user_id, presence: true

  def self.record_visit!(user, shortened_url)
    Visit.create!(
      user_id: user.id,
      shortened_url_id: shortened_url.id
    )
  end

    belongs_to(
      :shortened_url,
      class_name: "ShortenedUrl",
      foreign_key: :shortened_url_id,
      primary_key: :id
    )

end