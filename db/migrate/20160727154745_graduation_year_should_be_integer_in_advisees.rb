class GraduationYearShouldBeIntegerInAdvisees < ActiveRecord::Migration
  def up
    change_column :advisees,
                  :graduation_year,
                  'integer USING CAST(graduation_year AS integer)',
                  null: false
  end

  def down
    change_column :advisees, :graduation_year, :string, null: false
  end
end
