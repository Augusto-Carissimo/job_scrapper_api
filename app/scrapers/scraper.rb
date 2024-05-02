# frozen_string_literal: true

require './config/environment'

class Scraper
  def self.scrape
    all_files = Dir.entries('./app/scrapers')
    excluded_files = ['driver.rb', 'scraper.rb', '..', '.']
    filtered_files = all_files.reject { |file| excluded_files.include?(file) }
    shuffled_files = filtered_files.shuffle
    shuffled_files
      .map {
        |file|
        basename = File.basename(file, File.extname(file)).classify.constantize
        Rails.logger.info "Setting up #{basename} scraper"
        basename.new.search
       }
  end
end
