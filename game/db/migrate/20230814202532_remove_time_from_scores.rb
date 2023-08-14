class RemoveTimeFromScores < ActiveRecord::Migration[7.0]
  def change
    change_column :scores, :created_at, :date
    change_column :scores, :updated_at, :date
  end
end
