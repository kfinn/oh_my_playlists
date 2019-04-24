require 'oh_my_rockness_token_authentication'

OH_MY_ROCKNESS_API = Her::API.new
OH_MY_ROCKNESS_API.setup url: 'https://www.ohmyrockness.com/api' do |c|
  c.use OhMyRocknessTokenAuthentication

  # Response
  c.use Her::Middleware::DefaultParseJSON

  # Adapter
  c.use Faraday::Adapter::NetHttp
end

