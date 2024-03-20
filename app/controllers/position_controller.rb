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

  private

  def delete_old_positions
    Position.where('created_at < ?', 1.week.ago).delete_all
    Rails.logger.info "Deleting old positions"

  end
end
