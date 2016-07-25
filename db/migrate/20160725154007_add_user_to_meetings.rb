class AddUserToMeetings < ActiveRecord::Migration
  def change
    add_reference :meetings, :user, null: false, index: true
  end
end
