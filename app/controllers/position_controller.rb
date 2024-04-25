require 'active_record'
require 'uri'

uri = URI.parse(Rails.application.credentials.elephant[:URL])
ActiveRecord::Base.establish_connection(adapter: 'postgresql', host: uri.host, username: uri.user, password: uri.password, database: uri.path.sub('/', ''))

class PositionController < ApplicationController
  def index
    @positions = Position.all.order('created_at ASC').reverse_order
    render json: @positions.to_json, status: :ok
  end

  def scraper
    ScraperJob.perform_later
  end

  def wake_up_api
    WakeUpApiJob.perform_later
  end

  def wake_up_selenium
    WakeUpSeleniumJob.perform_later
  end
end
