IdeaWick::Application.configure do
  
  config.middleware.insert_after(::Rack::Lock, "::Rack::Auth::Basic", "IdeaWick QA Environment") do |u, p|
    [u, p] == [ENV['IW_QA_USERNAME'], ENV["IW_QA_PASSWORD"]]
  end
  config.cache_classes = true
  config.consider_all_requests_local       = false
  config.action_controller.perform_caching = true
  config.serve_static_assets = false
  config.assets.compress = true
  config.assets.compile = false
  config.assets.digest = true
  config.i18n.fallbacks = true
  config.active_support.deprecation = :notify
  
end
