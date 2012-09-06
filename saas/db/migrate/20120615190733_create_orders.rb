class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.string :id
      t.string :order_number
      t.integer :customer_id
      t.float :price
      t.string :delivery_option
      t.string :lead_source
      t.float :finishing_cost
      t.float :delivery_charge
      t.float :sales_tax
      t.float :balance
      t.integer :status

      t.timestamps
    end
  end
end
