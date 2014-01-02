class AddConsolidatedNotesToReview < ActiveRecord::Migration
  def change
    add_column :reviews, :consolidated_notes, :text
  end
end
