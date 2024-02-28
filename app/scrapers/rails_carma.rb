# frozen_string_literal: true

class RailsCarma < Driver
  SEARCH_KEY = 'https://www.railscarma.com/careers/'

  def search
    Rails.logger.info 'Starting Rails Carma search'
    @driver.navigate.to SEARCH_KEY
    elements = @driver.find_elements(:css, 'div.uael-module-content.uael-infobox.uael-imgicon-style-normal.uael-infobox-left.infobox-has-icon.uael-infobox-icon-above-title.uael-infobox-link-type-button')
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
      title = element.find_element(:css, 'h3.uael-infobox-title.elementor-inline-editing').text
      company = 'RailsCarma'
      link = element.find_element(:css, 'a.elementor-button-link.elementor-button.elementor-size-sm').attribute('href')
      website = 'RailsCarma'
      Position.create!(title:, company:, link:, website:) if Position.find_by(link:).nil?
    end
  end
end
