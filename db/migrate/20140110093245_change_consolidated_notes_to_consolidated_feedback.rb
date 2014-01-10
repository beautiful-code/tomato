class ChangeConsolidatedNotesToConsolidatedFeedback < ActiveRecord::Migration
  def up
    remove_column :reviews, :consolidated_notes
    add_column :reviews, :consolidated_feedback, :text
  end

  def down
    remove_column :reviews, :consolidated_feedback
    add_column :reviews, :consolidated_notes, :text
  end
end
