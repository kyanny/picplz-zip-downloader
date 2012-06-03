class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider
      t.string :client_id
      t.string :display_name

      t.timestamps
    end
  end
end
