class AddLikesDislikesToReply < ActiveRecord::Migration[7.0]
  def change
    add_column :replies, :likes, :integer, default: 0
    add_column :replies, :dislikes, :integer, default: 0
  end
end
