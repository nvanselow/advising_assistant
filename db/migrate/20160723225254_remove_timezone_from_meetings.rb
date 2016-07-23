class RemoveTimezoneFromMeetings < ActiveRecord::Migration
  def change
    remove_column :meetings,
                  :timezone,
                  :string,
                  null: false,
                  default: 'America/New_York'
  end
end
