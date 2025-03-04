require 'active_record'
require 'uri'

class PositionController < ApplicationController
  def index
    @positions = Position.all.order('created_at ASC').reverse_order
    delete_old_positions
    render json: @positions.to_json, status: :ok
  end

  def scraper
    Rails.logger.info "Initializing scrapping"
    Scraper.scrape
    Rails.logger.info "Scrapping finished"
    render json: { message: 'Scrapping finished' }, status: :ok
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
