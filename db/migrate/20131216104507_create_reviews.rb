class CreateReviews < ActiveRecord::Migration

  def change
    create_table :reviews do |t|
      t.string :title
      t.text :desc
      t.string :source
      t.datetime :review_created_at
      t.string :author
      t.decimal :rating
      t.string :digest
      t.references :restaurant
      t.text :consolidated_notes

      t.timestamps
    end

    add_index :reviews, [:id, :digest]
    add_index :reviews, [:id, :restaurant_id]
  end

end
