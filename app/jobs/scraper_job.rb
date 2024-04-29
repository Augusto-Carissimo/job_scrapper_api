class ScraperJob < ApplicationJob
  queue_as :default
  attr_accessor :job_finished

  def perform
    wake_up_selenium
    scrape
  end

  private

  def wake_up_selenium
    Rails.logger.info 'Walking up Selenium server'
    driver = Driver.new
  rescue StandardError => e
    Rails.logger.warn "Error trying to wake up Selenium: #{e.message}"
    ensure
    driver.quit
  end

  def scrape
    Rails.logger.info "Initializing scrapping"
    Scraper.scrape
  end
end
