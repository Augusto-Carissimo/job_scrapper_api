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

  def test
    @test = 'test'
    render json: @test.to_json
  end

  private

  def delete_old_positions
    Position.where('created_at < ?', 1.month.ago).delete_all
    Rails.logger.info "Deleting old positions"
  end
end
