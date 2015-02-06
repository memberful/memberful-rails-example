require "omniauth-memberful"
Rails.application.config.middleware.use OmniAuth::Builder do
  provider OmniAuth::Strategies::Memberful, Rails.application.secrets.omniauth_provider_key, Rails.application.secrets.omniauth_provider_secret
end
