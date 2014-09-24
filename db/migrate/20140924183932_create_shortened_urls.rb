class CreateShortenedUrls < ActiveRecord::Migration
  def change
    create_table :shortened_urls do |t|
      t.string :shortened_url
      t.string :long_url
      t.integer :submitter_id

      t.timestamps
    end
  end
end
