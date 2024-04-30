require 'active_record'
require 'uri'

uri = URI.parse(Rails.application.credentials.elephant[:URL])
ActiveRecord::Base.establish_connection(adapter: 'postgresql', host: uri.host, username: uri.user, password: uri.password, database: uri.path.sub('/', ''))

class PositionController < ApplicationController
  def index
    @positions = Position.all.order('created_at ASC').reverse_order

    DeleteOldPositionsJob.set(wait: 2.minutes).perform_later
    # scraper_job = ScraperJob.set(wait: 2.minutes).perform_later
    render json: @positions.to_json, status: :ok
    # poll_scraper_job_status(scraper_job)
  end

  def test
    render json: { message: 'test' }, status: :ok
  end

  def wake_up_selenium
    WakeUpSeleniumJob.perform_later
    render json: { message: 'Walking up Selenium' }, status: :ok
  end

  def scraper
    ScraperJob.set(wait: 2.minutes).perform_later
    render json: { message: 'Scraping init' }, status: :ok
  end

  private

  def delete_old_positions
    Rails.logger.info "Deleting old positions"
    Position.where('created_at < ?', 1.month.ago).delete_all
    Rails.logger.info "Old positions deleted"
  end

  # def poll_scraper_job_status(job)
  #   loop do
  #     if job.completed?
  #       @status = true
  #       render json: { status: @status }.to_json, status: :ok
  #       break
  #     else
  #       sleep(60)
  #     end
  #   end
  # end
end
