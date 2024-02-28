# frozen_string_literal: true

class RailsGarage < Driver
  SEARCH_KEY = 'https://rubygarage.org/company/careers'

  def search
    Rails.logger.info 'Starting Rails Garage search'
    @driver.navigate.to SEARCH_KEY
    elements = @driver.find_element(:css, 'section.vacancies')
                      .find_elements(:css, 'div.col-md-6.service-card')
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
      title = element.find_element(:css, 'h4.vacancies__item--title').text
      company = 'RailsGarage'
      link = element.find_element(:css, 'a.vacancies__item').attribute('href')
      website = 'RailsGarage'
      Position.create!(title:, company:, link:, website:) if Position.find_by(link:).nil?
    end
  end
end
