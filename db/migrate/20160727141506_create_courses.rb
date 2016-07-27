class CreateCourses < ActiveRecord::Migration
  def change
    create_table :courses do |t|
      t.string :name, null: false
      t.belongs_to :semester

      t.timestamps
    end
  end
end
