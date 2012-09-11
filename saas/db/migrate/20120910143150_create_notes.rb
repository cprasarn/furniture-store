class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :order_number
      t.string :note_type
      t.string :content

      t.timestamps
    end
  end
end
