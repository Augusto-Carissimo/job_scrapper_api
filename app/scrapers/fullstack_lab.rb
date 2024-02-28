# frozen_string_literal: true

class FullstackLab < Driver
  SEARCH_KEY = 'https://jobs.lever.co/fullstacklabs/'

  def search
    Rails.logger.info 'Starting Fullstack Labs search'
    @driver.navigate.to SEARCH_KEY
    elements = @driver.find_element(:css, 'div.postings-group').find_elements(:css, 'div.posting')
    filter_elements = []
    elements.filter_map { |element| filter_elements << element if element.text.downcase.include? 'ruby'}
    assign_values(filter_elements)
    Rails.logger.info 'Search finished'
  rescue StandardError => e
    Rails.logger.warn e.message
  ensure
    quit
  end

  private

  def assign_values(elements)
    elements.each do |element|
      title = element.find_element(:css, 'h5').text
      company = 'FullstackLabs'
      link = element.find_element(:css, 'a').attribute('href')
      website = 'FullstackLabs'
      Position.create!(title:, company:, link:, website:) if Position.find_by(link:).nil?
    end
  end
end
