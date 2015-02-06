require "omniauth-memberful"

secrets = Rails.application.secrets
Rails.application.config.middleware.use OmniAuth::Builder do
  provider OmniAuth::Strategies::Memberful,
    secrets.omniauth_provider_key,
    secrets.omniauth_provider_secret,
    client_options: { site: secrets.memberful_site }
end
