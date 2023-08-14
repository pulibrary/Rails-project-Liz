# Create migration resource: https://guides.rubyonrails.org/active_record_migrations.html#creating-a-standalone-migration
class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.string :name
      t.string :username

      t.timestamps
    end
  end
end
