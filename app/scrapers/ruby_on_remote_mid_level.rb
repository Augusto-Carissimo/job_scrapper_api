# frozen_string_literal: true

class RubyOnRemoteMidLevel < Driver
  SEARCH_KEY = 'https://rubyonremote.com/mid-level-remote-jobs/'

  def search
    Rails.logger.info 'Starting Ruby On Remote Mid Level search'
    @driver.navigate.to SEARCH_KEY
    elements = @driver.find_element(:css, 'main')
                      .find_elements(:css, 'ul')[1]
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
      title = element.find_element(:class, 'text-lg').text
      company = element.find_element(:class, 'text-base').text
      link = element.find_element(:css, 'a').attribute('href')
      website = 'RubyOnRemoteMidLevel'
      Position.create!(title:, company:, link:, website:) if Position.find_by(link:).nil?
    end
  end
end
