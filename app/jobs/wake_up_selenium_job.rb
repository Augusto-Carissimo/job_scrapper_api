class WakeUpSeleniumJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info 'Walking up Selenium server'
    driver = Driver.new
  rescue StandardError => e
    Rails.logger.warn "Error trying to wake up Selenium: #{e.message}"
  ensure
    driver.quit
    redirect_to root_path
  end
end
