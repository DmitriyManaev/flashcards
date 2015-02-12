class RemoveCurrentFromPack < ActiveRecord::Migration
  def change
    remove_column :packs, :current, :boolean
  end
end
