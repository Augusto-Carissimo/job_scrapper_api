require 'net/http'
require 'uri'

class WakeUpSeleniumJob < ApplicationJob
  queue_as :default

  def perform
    # script_path = Rails.root.join('lib', 'scripts', 'wake_up_selenium.rb')
    # system("ruby #{script_path}")

    # if $?.success?
    #   Rails.logger.info 'Request sent to Selenium server'
    # else
    #   Rails.logger.error 'Failed to send request to Selenium server'
    # end


    url = URI.parse('https://standalone-chrome-beta-2.onrender.com/ui/')
    request = Net::HTTP::Get.new(url)

    host = url.host
    port = url.port
    use_ssl = (url.scheme == 'https')
    open_timeout = 120
    read_timeout = 150

    begin
      response = Net::HTTP.start(host, port, use_ssl: use_ssl, open_timeout: open_timeout, read_timeout: read_timeout) do |http|
        http.request(request)
      end

      if response.code == '200'
        puts "Server up"
      else
        puts "Error: #{response.code} - #{response.message}"
      end
    rescue StandardError => e
      puts "Error: #{e.message}"
    end
  end
end




