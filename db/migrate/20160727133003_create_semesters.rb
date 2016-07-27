class CreateSemesters < ActiveRecord::Migration
  def change
    create_table :semesters do |t|
      t.string :semester, null: false
      t.integer :year, null: false
      t.boolean :remaining_courses, null: false, default: false
      t.belongs_to :graduation_plan

      t.timestamps null: false
    end
  end
end
