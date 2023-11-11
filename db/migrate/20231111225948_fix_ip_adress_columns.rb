class FixIpAdressColumns < ActiveRecord::Migration[7.1]
  def change
    add_column :ips, :ip, :string
  end
end
