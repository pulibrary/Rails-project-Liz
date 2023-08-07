class CreateScores < ActiveRecord::Migration[7.0]
  def change
    create_table :scores do |t|
      t.datetime :datetime
      t.integer :score
      t.references :user, null: false, foreign_key: true

      t.timestamps
    end
  end
end
