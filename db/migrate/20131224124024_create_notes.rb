class CreateNotes < ActiveRecord::Migration
  def change
    create_table :notes do |t|
      t.string :item
      t.float :rating
      t.references :feedback

      t.timestamps
    end
    add_index :notes, :feedback_id
  end
end
