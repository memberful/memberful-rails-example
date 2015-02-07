require "omniauth"
require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Memberful < OmniAuth::Strategies::OAuth2
      option :name, "memberful"

      option :client_options,
        site: ENV.fetch("MEMBERFUL_SITE") { "https://yoursite.memberful.com" },
        authorize_url: "/oauth",
        token_url: "/oauth/token"

      option :authorize_options, [:scope]

      # For more info, see https://github.com/intridea/omniauth/wiki/Auth-Hash-Schema

      uid { member_info["id"] }

      info do
        prune!(
          "nickname" => member_info["username"],
          "name" => member_info["full_name"],
          "email" => member_info["email"],
          "first_name" => member_info["first_name"],
          "last_name" => member_info["last_name"]
        )
      end

      extra do
        prune!("raw_info" => raw_info)
      end

      protected

      def raw_info
        @raw_info ||= retrieve_account_info
      end

      def member_info
        raw_info["member"]
      end

      def retrieve_account_info
        access_token.options[:mode] = :query
        access_token.get("/account.json").parsed
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
