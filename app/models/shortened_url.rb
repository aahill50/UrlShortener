class ShortenedUrl < ActiveRecord::Base
  validates :shortened_url, :long_url,
            presence: true,
            uniqueness: true


  # def self.already_exists?(code)
  #   ShortenedUrl.any? do |url|
  #     url.shortened_url == code
  #   end
  # end

  def self.random_code
    code = SecureRandom::urlsafe_base64[0..15]

    while ShortenedUrl.exists?(shortened_url: code)
      code = SecureRandom::urlsafe_base64[0..15]
    end

    code
  end

  def self.create_for_user_and_long_url!(user,long_url)
    ShortenedUrl.create!(
      shortened_url: self.random_code,
      long_url: long_url,
      submitter_id: user.id
    )
  end

  belongs_to(
    :submitter,
    class_name: "User",
    foreign_key: :submitter_id,
    primary_key: :id
  )

  has_many(
    :visitors,
    class_name: "Visit",
    foreign_key: :shortened_url_id,
    primary_key: :id
  )

  def num_clicks
    self.visitors.count
  end

  def num_uniques
    self.visitors.select(:user_id).distinct.count
  end

  def num_recent_uniques
    self.visitors
        .where(created_at: (10.minutes.ago)..(Time.now))
        .select(:user_id)
        .distinct
        .count
  end

end