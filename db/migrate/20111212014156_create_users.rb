class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :login
      t.string :name
      t.string :persistence_token
      t.datetime :last_login_at

      t.timestamps
    end
  end
end
