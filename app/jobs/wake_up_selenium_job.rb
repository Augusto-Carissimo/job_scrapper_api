require 'net/http'
require 'uri'

class WakeUpSeleniumJob < ApplicationJob
  queue_as :default

  def perform
    script_path = Rails.root.join('lib', 'scripts', 'wake_up_selenium.rb')
    system("ruby #{script_path}")

    if $?.success?
      Rails.logger.info 'Selenium server woke up successfully'
    else
      Rails.logger.error 'Failed to wake up Selenium server'
    end
end




