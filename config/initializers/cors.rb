Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'chrome-extension://your-extension-id-here'  # Adjust this to the domains you want to allow (e.g., 

    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      expose: ['access-token', 'expiry', 'token-type', 'uid', 'client'], # Add any custom headers you are using
      max_age: 600
  end
end
