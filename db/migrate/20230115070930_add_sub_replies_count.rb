class AddSubRepliesCount < ActiveRecord::Migration[7.0]
  def change
    add_column :replies, :replies_count, :integer, default: 0
  end
end
