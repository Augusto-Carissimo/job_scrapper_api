require 'net/http'
require 'uri'

class WakeUpSeleniumJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info 'Walking up Selenium server'
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

    if response.code == '200'
      Rails.logger.info "Selenium server active: #{response.code}"
    else
      Rails.logger.warn "Error trying to wake up Selenium: #{response.code} - #{response.message}"
    end

  rescue StandardError => e
    Rails.logger.warn "Error trying to wake up Selenium: #{e.message}"
  end
end




