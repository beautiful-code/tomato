class AddIndexOnReviewsAndRestaurants < ActiveRecord::Migration
  def change
    add_index :reviews, [:id, :restaurant_id]
  end
end
