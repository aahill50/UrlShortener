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

end