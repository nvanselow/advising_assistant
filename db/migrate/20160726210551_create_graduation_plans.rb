class CreateGraduationPlans < ActiveRecord::Migration
  def change
    create_table :graduation_plans do |t|
      t.string :name
      t.belongs_to :advisee

      t.timestamps null: false
    end
  end
end
