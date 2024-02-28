# frozen_string_literal: true

class Thoughtbot < Driver
  SEARCH_KEY = 'https://thoughtbot.com/jobs#jobs'

  def search
    Rails.logger.info 'Starting Thoughtbot search'
    @driver.navigate.to SEARCH_KEY
    element = @driver.find_element(:css, 'section.container.container--narrow.u-margin-bottom-6')
                     .find_element(:css, 'div.long-form-content').text
    assign_values if element != "We currently have no open positions."
    Rails.logger.info 'Search finished'
  rescue StandardError => e
    Rails.logger.warn e.message
  ensure
    quit
  end

  private

  def assign_values
    title = 'New position in Thoughtbot'
    company = 'Thoughtbot'
    link = 'https://thoughtbot.com/jobs#jobs'
    website = 'REFACTOR SCRAPER TO SAVE CORRECT LINK'
    Position.create!(title:, company:, link:, website:)
  end
end
