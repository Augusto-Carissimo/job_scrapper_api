# frozen_string_literal: true

class Reinteractive < Driver
  SEARCH_KEY = 'https://reinteractive.com/careers'

  def search
    Rails.logger.info 'Starting Reinteractive search'
    @driver.navigate.to SEARCH_KEY
    elements = @driver.find_element(:id, 'SC-ContentBlock-p-left-careers')
                        .find_element(:css, 'ul')
                        .find_elements(:css, 'li')
    assign_values(elements)
    Rails.logger.info 'Search finished'
  rescue StandardError => e
    Rails.logger.warn e.message
  ensure
    quit
  end

  private

  def assign_values(elements)
    elements.each do |element|
      title = element.text
      company = 'Reinteractive'
      link = 'https://reinteractive.com/careers'
      website = 'Reinteractive'
      Position.create!(title:, company:, link:, website:) if Position.find_by(title:).nil?
    end
  end
end