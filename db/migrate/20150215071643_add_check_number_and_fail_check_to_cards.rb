class AddCheckNumberAndFailCheckToCards < ActiveRecord::Migration
  def change
    add_column :cards, :check_number, :integer, default: 0
    add_column :cards, :fail_check, :integer, default: 0
  end
end
