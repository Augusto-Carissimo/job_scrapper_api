class WakeUpSeleniumJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info 'Walking up Selenium server'
    Driver.new.quit
    redirect_to root_path
  end
end
