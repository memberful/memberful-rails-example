require "omniauth"
require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Memberful < OmniAuth::Strategies::OAuth2

      option :name, "memberful"

      option :client_options, {
        :site => ENV.fetch("MEMBERFUL_SITE") { "https://yoursite.memberful.com" },
        :authorize_url => "/oauth",
        :token_url => "/oauth/token"
      }

      option :authorize_options, [:scope]

      # For more info, see https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema

      uid { raw_info["id"] }

      info do
        prune!({
          "nickname" => raw_info["username"],
          "name" => raw_info["full_name"],
          "email" => raw_info["email"],
          "location" => raw_info["address"],
          "first_name" => raw_info["first_name"],
          "last_name" => raw_info["last_name"]
        })
      end

      extra do
        prune!({
          "raw_info" => raw_info
        })
      end

      def raw_info
        @raw_info ||= raw_credentials_json["member"]
      end

      protected

      def raw_credentials_json
        @raw_credentials_json ||= begin
                                    access_token.options[:mode] = :query
                                    access_token.get("/account.json").parsed
                                  end
      end

      def prune!(hash)
        hash.delete_if do |_, value|
          prune!(value) if value.is_a?(Hash)
          value.nil? || (value.respond_to?(:empty?) && value.empty?)
        end
      end
    end
  end
end
