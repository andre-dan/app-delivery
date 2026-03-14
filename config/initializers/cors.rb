Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    # In development allow the Flutter emulator/device and localhost.
    # In production, replace "*" with your deployed frontend origin.
    origins Rails.env.production? ? ENV.fetch("ALLOWED_ORIGINS", "").split(",") : "*"

    resource "/api/*",
             headers:     :any,
             methods:     [:get, :post, :patch, :put, :delete, :options, :head],
             credentials: false,
             max_age:     86_400
  end
end
