# frozen_string_literal: true

class DeleteAddressService
  attr_reader :address

  def initialize(address)
    @address = address
  end

  def call
    raise ActiveRecord::RecordNotFound unless found_entity

    found_entity.delete
    true
  end

  private

  def found_entity
    Address.find_by(address: @address)
  end
end
