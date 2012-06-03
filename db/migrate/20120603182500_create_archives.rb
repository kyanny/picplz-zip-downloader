class CreateArchives < ActiveRecord::Migration
  def change
    create_table :archives do |t|
      t.integer :user_id
      t.downloaded :

      t.timestamps
    end
  end
end
