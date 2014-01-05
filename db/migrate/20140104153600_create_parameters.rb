class CreateParameters < ActiveRecord::Migration
  def change
    create_table :parameters do |t|
      t.text :content
      t.references :feedback

      t.timestamps
    end
    add_index :parameters, :feedback_id
  end
end
