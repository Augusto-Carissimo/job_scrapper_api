require 'active_record'
require 'uri'

uri = URI.parse(Rails.application.credentials.elephant[:URL])
ActiveRecord::Base.establish_connection(adapter: 'postgresql', host: uri.host, username: uri.user, password: uri.password, database: uri.path.sub('/', ''))

class PositionController < ApplicationController
  def index
    @positions = Position.all.order('created_at ASC').reverse_order
    scraper_job = ScraperJob.perform_later
    render json: @positions.to_json, status: :ok
    poll_scraper_job_status(scraper_job)
  end

  def test
    render json: { message: 'test' }, status: :ok
  end

  private

  def poll_scraper_job_status(job)
    loop do
      if job.completed?
        @status = job.job_finished
        render json: { status: @status }.to_json, status: :ok
        break
      else
        sleep(60)
      end
    end
  end
end
