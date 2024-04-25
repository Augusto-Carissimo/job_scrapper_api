class WakeUpApiJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info 'Walking up API'
  end
end
