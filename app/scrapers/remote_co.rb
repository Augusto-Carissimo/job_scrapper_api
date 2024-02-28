# frozen_string_literal: true

class RemoteCo < Driver
  SEARCH_KEY = 'https://remote.co/remote-jobs/search/?search_keywords=ruby'

  def search
    Rails.logger.info 'Starting Remote.Co search'
    @driver.navigate.to SEARCH_KEY
    wait
    elements = @driver.find_elements(:class, 'job_listings')[-1]
                      .find_elements(:class, 'card ')
    assign_values(elements)
    Rails.logger.info 'Search finished'
  rescue StandardError => e
    Rails.logger.warn e.message
  ensure
    quit
  end

  private

  def wait
    wait = Selenium::WebDriver::Wait.new
    wait.until { @driver.find_elements(:class, 'job_listings')[-1].text != 'Loading...' }
  end

  def assign_values(elements)
    elements.each do |element|
      info = element.find_elements(:class, 'm-0')
      title = info[0].text
      company = info[1].text.split('|')[0].strip
      link = element.find_element(:css, 'a').attribute('href')
      website = 'remote.co'
      Position.create!(title:, company:, link:, website:) if Position.find_by(link:).nil?
    end
  end
end
