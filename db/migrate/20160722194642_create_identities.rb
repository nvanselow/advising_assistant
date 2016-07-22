class CreateIdentities < ActiveRecord::Migration
  def change
    create_table :identities do |t|
      t.string :uid, null: false, index: true
      t.string :provider, null: false
      t.belongs_to :user

      t.timestamps null: false
    end
    add_index :identities, :user_id
  end
end
