class CreatePacks < ActiveRecord::Migration
  def change
    create_table :packs do |t|
      t.string :title
      t.string :image
      t.integer :user_id

      t.timestamps null: false
    end
    add_index :packs, :user_id
  end
end
