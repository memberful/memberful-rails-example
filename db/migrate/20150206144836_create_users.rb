class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uid
      t.string :provider
      t.string :name
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email

      t.timestamps null: false
    end

    add_index :users, [:uid, :provider]
  end
end
