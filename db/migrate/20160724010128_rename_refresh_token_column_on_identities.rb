class RenameRefreshTokenColumnOnIdentities < ActiveRecord::Migration
  def change
    rename_column :identities, :referesh_token, :refresh_token
  end
end
