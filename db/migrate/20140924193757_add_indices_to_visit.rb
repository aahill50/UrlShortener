class AddIndicesToVisit < ActiveRecord::Migration
  def change
    add_index :visits, :shortened_url_id
    add_index :visits, :user_id
  end
end
