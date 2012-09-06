class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.string :id
      t.string :order_number
      t.string :image_uri
      t.string :description
      t.integer :status

      t.timestamps
    end
  end
end
