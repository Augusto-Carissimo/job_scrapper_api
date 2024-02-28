# frozen_string_literal: true

require './config/environment'

class Scraper
  def self.scrape
    Dir.entries('./app/scrapers').excluding('driver.rb', 'scraper.rb', '..', '.')
      .map { |file| File.basename(file, File.extname(file)).classify.constantize.new.search }
  end
end
