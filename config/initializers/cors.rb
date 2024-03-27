Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins Rails.application.credentials.netlify[:URL]
    resource '/position', headers: :any, methods: [:get]
    resource '/position/scraper', headers: :any, methods: [:get]
  end
end

