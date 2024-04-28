# frozen_string_literal: true

require 'selenium-webdriver'
require './config/environment'
require 'dotenv'
require 'active_record'
require 'uri'

class Driver
  def initialize
    uri = URI.parse(Rails.application.credentials.elephant[:URL])
    ActiveRecord::Base.establish_connection(adapter: 'postgresql', host: uri.host, username: uri.user, password: uri.password, database: uri.path.sub('/', ''))

    Rails.logger.info 'Configuring Driver'
    options = Selenium::WebDriver::Chrome::Options.new
    options.add_argument('--ignore-certificate-errors')
    options.add_argument('--disable-popup-blocking')
    options.add_argument('--disable-translate')
    @driver = Selenium::WebDriver.for(
      :remote,
      url: Rails.application.credentials.render_selenium_host[:SELENIUM_HOST],
      options:
    )
    Rails.logger.info 'Driver initialized'

  rescue StandardError => e
    Rails.logger.warn "Error at driver initialization: #{e.message}"
  end

  def quit
    Rails.logger.info 'Closing Driver'
    @driver.quit
  rescue StandardError => e
    Rails.logger.warn "Error at quiting driver: #{e.message}"
  end
end
