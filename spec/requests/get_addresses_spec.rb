require 'rails_helper'

RSpec.describe 'GetAddresses', type: :request do

  describe 'GET /api/geolocation?address=83.7.26.22' do
    it 'has a valid factory' do
      expect(build(:address)).to be_valid
    end

    it 'returns address data' do
      get '/api/geolocation?address=83.7.26.222'
      expect { JSON.parse(response.body) }.not_to raise_error
      response_body = JSON.parse(response.body)

      expect(response).to have_http_status(200)
      expect(response_body['country_code']).to eql('PL')
    end
  end
end
