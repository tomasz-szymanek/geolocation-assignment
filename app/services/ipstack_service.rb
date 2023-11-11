class IpstackService < ApplicationService
  attr_reader :address

  private def parse_response(geolocation_data)
    hash = JSON.parse geolocation_data

    hash.transform_keys!(&:to_sym)
    hash[:ip_type] = hash[:type]
    hash.slice!(:ip, :ip_type, :country_code, :country_name, :city, :zip, :latitude, :longitude)

    if @address == hash[:ip]
      hash[:address] = hash[:ip]
    else
      hash[:address] = @address
    end

    hash
  end

  def initialize(address)
    @address = address
  end

  def call
    begin
      geolocation_data = HTTP.get("http://api.ipstack.com/#{@address}?access_key=#{ENV['IPSTACK_ACCESS_KEY']}").to_s
    rescue ConnectionError => error
      connection_error = error.to_s
    rescue error
      raise Error.new('Unexpected error occured: ' + error.to_s)
    end

    if connection_error
      return connection_error
    end

    parse_response geolocation_data
  end
end