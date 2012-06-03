class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.integer :user_id
      t.string :public_url
      t.boolean :available

      t.timestamps
    end
  end
end
