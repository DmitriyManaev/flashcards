class AddCurrentPackIdToUser < ActiveRecord::Migration
  def change
    add_column :users, :current_pack_id, :integer
    add_index :users, :current_pack_id
  end
end
