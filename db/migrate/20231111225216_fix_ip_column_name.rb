class FixIpColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :ips, :ip, :address
  end
end
