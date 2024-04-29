require 'active_record'
require 'uri'

uri = URI.parse(Rails.application.credentials.elephant[:URL])
ActiveRecord::Base.establish_connection(adapter: 'postgresql', host: uri.host, username: uri.user, password: uri.password, database: uri.path.sub('/', ''))

class PositionController < ApplicationController
  def index
    @positions = Position.all.order('created_at ASC').reverse_order
    # ScraperJob.perform_later
    render json: @positions.to_json, status: :ok
  end

  def test
    render json: { message: 'test' }, status: :ok
  end
end
