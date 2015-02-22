class AddIntevalToReviewAndEFactorToCard < ActiveRecord::Migration
  def change
    add_column :cards, :interval_to_review, :integer, default: 0
    add_column :cards, :e_factor, :decimal, precision: 3, scale: 2, default: 2.5
  end
end
