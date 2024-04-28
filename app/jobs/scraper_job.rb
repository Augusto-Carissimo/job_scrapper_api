class ScraperJob < ApplicationJob
  queue_as :default

  def perform
    delete_old_positions
    Rails.logger.info "Initializing scrapping"
    Scraper.scrape
  end

  private

  def delete_old_positions
    Rails.logger.info "Deleting old positions"
    Position.where('created_at < ?', 1.month.ago).delete_all
    Rails.logger.info "Old positions deleted"
  end
end
