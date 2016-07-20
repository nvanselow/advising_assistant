class AddPhotoToAdvisees < ActiveRecord::Migration
  def change
    add_column :advisees, :photo, :string
  end
end
