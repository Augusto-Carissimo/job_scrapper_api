Rails.application.routes.draw do
  root 'position#index'
  get 'position/scraper'
  get 'position/test'
  get 'position/wake_up_api'
  get 'position/wake_up_selenium'
  resources 'position', only: [:index]
end
