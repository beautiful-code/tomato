class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.string :title
      t.text :desc
      t.string :source
      t.datetime :review_created_at
      t.datetime :created_at
      t.string :author
      t.references :restaurant
      t.timestamps
    end
  end
end
