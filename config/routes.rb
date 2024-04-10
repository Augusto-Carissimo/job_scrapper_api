Rails.application.routes.draw do
  root 'position#index'
  get 'position/scraper'
  get 'position/test'
  resources 'position'
end
