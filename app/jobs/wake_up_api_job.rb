class WakeUpApiJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info 'Walking up API'
    redirect_to root_path
  end
end
