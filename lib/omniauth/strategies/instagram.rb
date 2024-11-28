require "omniauth-oauth2"

module OmniAuth
  module Strategies
    class Instagram < OmniAuth::Strategies::OAuth2
      DEFAULT_SCOPE = "instagram_business_basic"
      DEFAULT_FIELDS = "user_id,username,name,account_type,profile_picture_url,followers_count,follows_count,media_count"

      option :name, "instagram"

      option :client_options, {
        site: "https://graph.instagram.com/v21.0",
        authorize_url: "https://api.instagram.com/oauth/authorize",
        token_url: "https://api.instagram.com/oauth/access_token"
      }

      option :scope, DEFAULT_SCOPE

      uid { raw_info["user_id"] }

      info do
        {
          name: raw_info["name"],
          nickname: raw_info["username"],
          image: raw_info["profile_picture_url"]
        }
      end

      credentials do
        {
          token: long_lived_token.token,
          expires_at: long_lived_token.expires_at,
          expires: long_lived_token.expires?
        }
      end

      extra { {raw_info: raw_info} }

      def token_params
        super.tap do |params|
          params[:client_id] = options.client_id
          params[:client_secret] = options.client_secret
        end
      end

      def callback_url
        full_host + callback_path
      end

      def raw_info
        @raw_info ||= long_lived_token.get("/me", params: {fields: DEFAULT_FIELDS}).parsed
      end

      def long_lived_token
        @long_lived_token ||= ::OAuth2::AccessToken.from_hash(client, access_token.get("/access_token", params: {grant_type: "ig_exchange_token", client_secret: options.client_secret, access_token: access_token.token}).parsed)
      end
    end
  end
end
