class CreateCustomersAddresses < ActiveRecord::Migration
  def change
    create_table :customers_addresses do |t|
      t.string :id
      t.integer :customer_id
      t.string :address_id
      t.string :type
      t.integer :status

      t.timestamps
    end
  end
end
