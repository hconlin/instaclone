class CreateFriendRequests < ActiveRecord::Migration[6.1]
  def change
    create_table :friend_requests do |t|
      t.integer :sent_from
      t.integer :sent_to
      t.string :status

      t.timestamps
    end
  end
end
