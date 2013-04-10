# Require deltacloud-client (will soon be obsoleted by https://github.com/mifo/deltacloud-client)
require 'deltacloud'

# Require deltacloud-core rack middleware
require 'deltacloud_rack'

# The default driver if the API_DRIVER environment variable is not set:
ENV['API_DRIVER'] ||= 'mock'

# The default frontend if the API_FRONTEND environment variable is not set:
ENV['API_FRONTEND'] ||= 'deltacloud'

Deltacloud::configure do |server|
  server.root_url '/api'
  server.version Deltacloud::API_VERSION
  server.klass 'Deltacloud::API'
end

Deltacloud[:deltacloud].require!(:mock_initialize => true)
