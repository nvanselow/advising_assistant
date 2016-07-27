class AddCreditsToCourses < ActiveRecord::Migration
  def change
    add_column :courses, :credits, :integer, null: false, default: 30
  end
end
