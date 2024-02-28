Rails.application.routes.draw do
  root 'position#index'
  get 'position/scraper'
  resources 'position'
end
