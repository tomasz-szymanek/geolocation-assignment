# frozen_string_literal: true

class Geolocation < Grape::API
  desc 'Endpoints for Geolocation'

  namespace :geolocation do
    desc 'Get geolocation data'
    params do
      requires :address, type: String, desc: 'address'
    end
    get do
      if params[:address].starts_with?('http://') || params[:address].starts_with?('https://')
        error! 'Use address without http://|https:// prefix', 400
      end
      begin
        GetAddressService.new(params[:address]).call
      rescue ActiveRecord::RecordNotFound => _e
        error! :not_found, 404
      end
    end

    desc 'Remove address from system'
    params do
      requires :address, type: String, desc: 'address'
    end
    delete do
      begin
        DeleteAddressService.new(params[:address]).call
      rescue ActiveRecord::RecordNotFound => _e
        error! :not_found, 404
      end

      status :no_content
    end
  end
end
