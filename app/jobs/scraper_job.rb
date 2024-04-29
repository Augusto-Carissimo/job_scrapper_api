class ScraperJob < ApplicationJob
  queue_as :default

  def perform
    wake_up_selenium
    delete_old_positions
    scrape
  end

  private

  def delete_old_positions
    Rails.logger.info "Deleting old positions"
    Position.where('created_at < ?', 1.month.ago).delete_all
    Rails.logger.info "Old positions deleted"
  end

  def scrape
    Rails.logger.info "Initializing scrapping"
    Scraper.scrape
    @status = true
    render json: @status.to_json
  end

  def wake_up_selenium
    Rails.logger.info 'Walking up Selenium server'
    driver = Driver.new
  rescue StandardError => e
    Rails.logger.warn "Error trying to wake up Selenium: #{e.message}"
  ensure
    driver.quit
  end
end
