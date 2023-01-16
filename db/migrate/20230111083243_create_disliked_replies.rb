class CreateDislikedReplies < ActiveRecord::Migration[7.0]
  def change
    create_table :disliked_replies do |t|
      t.references :user, null: false, foreign_key: true
      t.references :reply, null: false, foreign_key: true

      t.timestamps
    end
  end
end
