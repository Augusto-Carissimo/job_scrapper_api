# frozen_string_literal: true

class RailsFactory < Driver
  SEARCH_KEY = 'https://railsfactory.com/careers'

  def search
    Rails.logger.info 'Starting Rails Factory search'
    @driver.navigate.to SEARCH_KEY
    elements = @driver.find_element(:class, 'career-loop-content')
                      .find_elements(:css, 'article.noo_job.hent')
    assign_values(elements)
    Rails.logger.info 'Search finished'
  rescue StandardError => e
    Rails.logger.warn "Error at Rails Factory scrapping: #{e.message}"
  ensure
    quit
  end

  private

  def assign_values(elements)
    elements.each do |element|
      title = element.text.chomp("Apply Now")
      company = 'Rails Factory'
      link = element.find_element(:css, 'a.btn.btn-primary.apply-btn').attribute('href')
      website = 'https://railsfactory.com/'
      Position.create!(title:, company:, link:, website:) if Position.find_by(title:).nil?
    end
  end
end