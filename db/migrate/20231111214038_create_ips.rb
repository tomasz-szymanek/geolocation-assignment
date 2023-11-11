class CreateIps < ActiveRecord::Migration[7.1]
  def change
    create_table :ips do |t|
      t.string :ip
      t.string :type
      t.string :country_code
      t.string :country_name
      t.string :city
      t.string :zip
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
