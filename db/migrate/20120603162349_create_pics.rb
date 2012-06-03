class CreatePics < ActiveRecord::Migration
  def change
    create_table :pics do |t|
      t.integer :user_id
      t.string :url
      t.boolean :downloaded
      t.boolean :archived

      t.timestamps
    end
  end
end
