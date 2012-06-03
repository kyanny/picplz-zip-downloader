class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :provider # auth['provider']
      t.string :uid      # auth['uid']
      t.string :nickname # auth['info']['nickname']
      t.string :url      # auth['info']['urls']['Picplz']
      t.string :image    # auth['info']['image']
      t.string :token    # auth['credentials']['token']
      t.string :secret   # auth['credentials']['secret']

      t.timestamps
    end
  end
end
