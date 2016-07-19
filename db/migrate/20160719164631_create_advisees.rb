class CreateAdvisees < ActiveRecord::Migration
  def change
    create_table :advisees do |t|
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.string :email, null: false
      t.string :graduation_semester, null: false
      t.string :graduation_year, null: false
      t.belongs_to :user

      t.timestamps null: false
    end
    add_index :advisees, :user_id
  end
end
