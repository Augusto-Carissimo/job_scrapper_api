require 'net/http'
require 'uri'

url = URI.parse('https://standalone-chrome-beta-2.onrender.com/ui/')
request = Net::HTTP::Get.new(url)

host = url.host
port = url.port
use_ssl = (url.scheme == 'https')
open_timeout = 120
read_timeout = 150

response = Net::HTTP.start(host, port, use_ssl:, open_timeout:, read_timeout:) do |http|
  http.request(request)
end
p response
if response.code == '200'
  p "Server up"
else
  p "Error: #{response.code} - #{response.message}"
end

rescue => e
  p e
