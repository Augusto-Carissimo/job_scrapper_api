# frozen_string_literal: true

require 'selenium-webdriver'
require './config/environment'
require 'dotenv'

class Driver
  def initialize
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
    Rails.logger.warn "Error at driver quiting: #{e.message}"
  end
end
