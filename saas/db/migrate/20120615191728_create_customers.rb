class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.integer :id
      t.string :name
      t.string :home_phone
      t.string :mobile_phone
      t.string :business_phone
      t.string :fax
      t.string :email
      t.integer :status

      t.timestamps
    end
  end
end
