class AddWhyToNote < ActiveRecord::Migration
  def change
    add_column :notes, :why, :string
  end
end
