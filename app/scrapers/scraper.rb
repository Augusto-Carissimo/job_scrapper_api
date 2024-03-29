# frozen_string_literal: true

require './config/environment'

class Scraper
  def self.scrape
    Dir.entries('./app/scrapers').excluding('driver.rb', 'scraper.rb', '..', '.')
      .map {
        |file|
        basename = File.basename(file, File.extname(file)).classify.constantize
        Rails.logger.info "Setting up #{basename} scraper"
        basename.new.search
       }
  end
end
