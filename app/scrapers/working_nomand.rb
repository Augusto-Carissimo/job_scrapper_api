# frozen_string_literal: true
require './config/environment'

class WorkingNomand < Driver
  SEARCH_KEY = 'https://www.workingnomads.com/jobs?tag=ruby'

  def search
    Rails.logger.info 'Starting Working Nomads search'
    @driver.navigate.to SEARCH_KEY
    elements = @driver.find_element(:class, 'jobs-list')
                      .find_elements(:css, 'div.job-desktop')
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
      title = element.find_element(:css, 'h4').text
      company = element.find_element(:css, 'div.company.hidden-xs').text
      link = element.find_element(:css, 'h4').find_element(:css, 'a').attribute('href')
      website = 'WorkingNomands'
      Position.create!(title:, company:, link:, website:) if Position.find_by(link:).nil?
    rescue StandardError => e
      PositionController e.message
    end
  end
end
