class AddParentToReplies < ActiveRecord::Migration[7.0]
  def change
    add_reference :replies, :reply, null: true, foreign_key: true
  end
end
