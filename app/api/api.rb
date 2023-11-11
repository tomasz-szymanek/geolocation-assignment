class API < Grape::API
  prefix 'api'
  mount Geolocation

  add_swagger_documentation hide_documentation_path: true,
                            api_version: 'v1',
                            info: {
                              title: 'Geolocation',
                              description: 'Demo app for geolocating via IP or http address using Ipstack'
                            }
end