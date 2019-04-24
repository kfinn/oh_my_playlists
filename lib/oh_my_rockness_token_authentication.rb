class OhMyRocknessTokenAuthentication < Faraday::Middleware
  def call(env)
    env[:request_headers]['Authorization'] = 'Token token="3b35f8a73dabd5f14b1cac167a14c1f6"'
    env.url.path = "#{env.url.path}.json"
    @app.call(env)
  end
end
