class Geolocation < Grape::API
  desc 'End-points for the Login'
  format :json

  namespace :geolocation do
    desc 'Manage geolocation data'
    params do
      optional :address, type: String, desc: 'address'
      exactly_one_of :ip, :address
    end
    get do

      parameter = params[:address]

      ip = Ip.find_by(address: parameter)

      if ip
        ip
      else
        ip = IpstackService.call(parameter)

        if ip.key?(:country_code)
          Ip.insert(ip)
          ip = Ip.find_by(address: parameter)
          ip
        else
          status :not_found
          { :status_code => 404, :response_type => 'error', :details => "Not found" }
        end
      end
    end

    desc 'Remove ip from system'
    params do
      optional :address, type: String, desc: 'address'
      exactly_one_of :ip, :address
    end
    delete do
      parameter = params[:address]

      found = Ip.find_by(address: parameter)

      if found
        found.delete
        status :no_content
        { :status => 'deleted' }
      else
        status :not_found
        { :status_code => 404, :response_type => 'error', :details => "Not found" }
      end
    end
  end
end
