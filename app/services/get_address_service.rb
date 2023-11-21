# frozen_string_literal: true

class GetAddressService
  attr_reader :address

  def initialize(address)
    @address = address
  end

  def call
    return found_entity if found_entity

    raise ActiveRecord::RecordNotFound unless entity_from_ipstack&.key?(:country_code)

    Address.insert(entity_from_ipstack)
    Address.find_by(address: @address)
  end

  private

  def found_entity
    Address.find_by(address: @address)
  end

  def entity_from_ipstack
    IpstackService.new(@address).call
  end
end
