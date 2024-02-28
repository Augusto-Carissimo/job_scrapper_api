class PositionController < ApplicationController
  def index
    @positions = positions
    render json: @positions.to_json
  end

  def scraper
    Scraper.scrape
    # if !positions.empty?
    #   PositionMailer.update(positions).deliver_now
    # end
    redirect_to root_path
  end

  private

  def positions
    Position.where('created_at > ?', 24.hours.ago).order('created_at ASC').reverse_order
  end
end
