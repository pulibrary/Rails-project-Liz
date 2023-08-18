class RemoveDatetimeColumnFromScores < ActiveRecord::Migration[7.0]
  def change
    remove_column :scores, :datetime
  end
end
