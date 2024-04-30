require 'active_record'
require 'uri'

class DeleteOldPositionsJob < ApplicationJob
  uri = URI.parse(Rails.application.credentials.elephant[:URL])
  ActiveRecord::Base.establish_connection(adapter: 'postgresql', host: uri.host, username: uri.user, password: uri.password, database: uri.path.sub('/', ''))

  queue_as :default

  def perform
    Rails.logger.info "Deleting old positions"
    Position.where('created_at < ?', 1.month.ago).delete_all
    Rails.logger.info "Old positions deleted"
  end
end