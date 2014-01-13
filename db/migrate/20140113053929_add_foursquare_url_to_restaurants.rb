class AddFoursquareUrlToRestaurants < ActiveRecord::Migration
  def change
    add_column :restaurants, :foursquare_url, :string
  end
end
