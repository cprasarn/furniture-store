class CreateLedgers < ActiveRecord::Migration
  def change
    create_table :ledgers do |t|
      t.string :id
      t.string :order_number
      t.string :payment_type
      t.string :payment_method
      t.float :amount
      t.date :payment_date
      t.int :status

      t.timestamps
    end
  end
end
