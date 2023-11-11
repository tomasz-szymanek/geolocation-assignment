class FixTypeColumnName < ActiveRecord::Migration[7.1]
  def change
    rename_column :ips, :type, :ip_type
  end
end
