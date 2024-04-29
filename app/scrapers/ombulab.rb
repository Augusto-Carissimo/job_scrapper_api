  # frozen_string_literal: true

  class Ombulab < Driver
    SEARCH_KEY = 'https://www.ombulabs.com/jobs'

    def search
      Rails.logger.info 'Starting Ombulabs search'
      @driver.navigate.to SEARCH_KEY
      element = @driver.find_element(:class, 'open-position-list')
      if element.text != "We don't have any open positions at the moment. Check back soon or keep an eye on Twitter and LinkedIn, we post new job openings there as they become available."
        elements = element.find_elements(:class, 'learn-more')
        assign_values(elements)
      end
      Rails.logger.info 'Search finished'
    rescue StandardError => e
      Rails.logger.warn e.message
    ensure
      quit
    end

    private

    def assign_values(elements)
      elements.each do |element|
        title =  element.find_element(css: 'span').text
        company = 'Ombulabs'
        link = element.attribute('href')
        website = 'https://www.ombulabs.com'
        Position.create!(title:, company:, link:, website:) if Position.find_by(link:).nil?
      end
    end
  end
