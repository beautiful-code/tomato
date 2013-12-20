class CreateRestaurants < ActiveRecord::Migration
  def change
    create_table :restaurants do |t|
      t.string :name
      t.string :address
      t.string :phone
      t.string :zomato_url
      t.string :burrp_url
      t.timestamps
    end
  end
end
