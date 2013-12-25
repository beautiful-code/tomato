class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :item
      t.float :rating
      t.references :review

      t.timestamps
    end
    add_index :notes, :review_id
  end
end
