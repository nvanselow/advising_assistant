class CreateMeetings < ActiveRecord::Migration
  def change
    create_table :meetings do |t|
      t.string :description
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.string :timezone, null: false
      t.belongs_to :advisee, null: false

      t.timestamps null: false
    end
    add_index :meetings, :advisee_id
  end
end
