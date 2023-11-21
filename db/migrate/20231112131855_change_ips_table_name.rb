class ChangeIpsTableName < ActiveRecord::Migration[7.1]
  def change
    rename_table :ips, :addresses
  end
end
