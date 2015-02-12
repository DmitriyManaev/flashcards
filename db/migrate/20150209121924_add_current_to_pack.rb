class AddCurrentToPack < ActiveRecord::Migration
  def change
    add_column :packs, :current, :boolean
  end
end
