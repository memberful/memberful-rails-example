class AddMemberfulColumnsToUsers < ActiveRecord::Migration
  def change
    change_table :users do |t|
      t.datetime :membership_created_at
      t.boolean :unrestricted_access
      t.string :stripe_customer_id
    end
  end
end
