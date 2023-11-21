# frozen_string_literal: true

class IpstackService
  attr_reader :address

  def initialize(address)
    @address = address
  end

  def call
    geolocation_data = HTTP.get(
      "http://api.ipstack.com/#{@address}?access_key=#{ENV.fetch('IPSTACK_ACCESS_KEY', nil)}"
    ).to_s

    parse_response geolocation_data
  end

  private

  def parse_response(geolocation_data)
    hash = JSON.parse geolocation_data

    hash.transform_keys!(&:to_sym)
    hash[:ip_type] = hash[:type]
    hash.slice!(:ip, :ip_type, :country_code, :country_name, :city, :zip, :latitude, :longitude)

    hash[:address] = if @address == hash[:ip]
                       hash[:ip]
                     else
                       @address
                     end
    hash
  end
end
