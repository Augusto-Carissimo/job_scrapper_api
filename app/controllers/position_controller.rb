class PositionController < ApplicationController
  def index
    @positions = Position.all.order('created_at ASC').reverse_order
    render json: @positions.to_json, status: :ok
  end

  def scraper
    delete_month_old
    Scraper.scrape
    @status = true
    render json: @status.to_json
  end

  private

  def delete_month_old
    Position.where('created_at < ?', 1.month.ago).delete_all
  end
end
