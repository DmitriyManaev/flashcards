class RemoveFailedAttemptsFromCard < ActiveRecord::Migration
  def change
    remove_column :cards, :failed_attempts, :integer
  end
end
