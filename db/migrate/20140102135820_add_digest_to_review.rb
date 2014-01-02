class AddDigestToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :digest, :string
    add_index :reviews, [:id, :digest]
  end
end
