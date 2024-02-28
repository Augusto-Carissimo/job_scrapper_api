# frozen_string_literal: true

class Netguru < Driver
  SEARCH_KEY = 'https://www.netguru.com/career'

  def search
    Rails.logger.info 'Starting Netguru search'
    @driver.navigate.to SEARCH_KEY
    elements = @driver.find_element(:css, 'div.job-offers__list')
                      .find_elements(:css, 'article.job-preview')
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
      title = element.find_element(:css, 'h2.job-preview__header.h4').text
      company = 'Netguru'
      link = element.find_element(:css, 'h2.job-preview__header.h4').find_element(:css, 'a').attribute('href')
      website = 'Netguru'
      Position.create!(title:, company:, link:, website:) if Position.find_by(link:).nil?
    end
  end
end