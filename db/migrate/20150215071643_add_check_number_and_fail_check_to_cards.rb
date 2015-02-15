class AddCheckNumberAndFailCheckToCards < ActiveRecord::Migration
  def change
    add_column :cards, :number_of_review, :integer, default: 0
    add_column :cards, :failed_attempts, :integer, default: 0
  end
end
