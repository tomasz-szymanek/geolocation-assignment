# frozen_string_literal: true

FactoryBot.define do
  factory :address do
    address { '83.7.26.222' }
    ip { '83.7.26.222' }
    ip_type { 'ip' }
    country_code { 'PL' }
    country_name { 'Poland' }
    city { 'Lodz' }
    zip { '40-717' }
    latitude { 1.5 }
    longitude { 1.5 }
  end
end
