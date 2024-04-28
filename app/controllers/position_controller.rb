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
    delete_old_positions
    Rails.logger.info "Initializing scrapping"
    Scraper.scrape
    @status = true
    render json: @status.to_json
  end

  def wake_up_api
    WakeUpApiJob.perform_later
    render json: { message: 'API script execution has been initiated.' }, status: :ok
  end

  def wake_up_selenium
    WakeUpSeleniumJob.perform_later
    render json: { message: 'Selenium script execution has been initiated.' }, status: :ok
  end

  def test
    render json: { message: 'test' }, status: :ok
  end

  private

  def delete_old_positions
    Rails.logger.info "Deleting old positions"
    Position.where('created_at < ?', 1.month.ago).delete_all
    Rails.logger.info "Old positions deleted"
  end
end
