class CreateFeedbacks < ActiveRecord::Migration
  def change
    create_table :feedbacks do |t|
      t.references :review
      t.references :user

      t.timestamps
    end
    add_index :feedbacks, :review_id
    add_index :feedbacks, :user_id
  end
end
