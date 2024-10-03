# Omniauth::InstagramAPI

[![Gem Version](https://badge.fury.io/rb/omniauth-instagram-api.svg)](https://badge.fury.io/rb/omniauth-instagram-api)
[![Build Status](https://github.com/giacomoguiulfo/omniauth-instagram-api/actions/workflows/main.yml/badge.svg)](https://github.com/giacomoguiulfo/omniauth-instagram-api/actions)
[![License](https://img.shields.io/badge/license-MIT-blue.svg)](LICENSE)

An OmniAuth strategy for authenticating with the [Instagram API with Instagram Login](https://developers.facebook.com/docs/instagram-platform/instagram-api-with-instagram-login) via OAuth.

> **Note**: Instagram API with Instagram Login is different from the [Instagram Login with Facebook Login](https://developers.facebook.com/docs/instagram-platform/instagram-api-with-facebook-login)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'omniauth-instagram-api'
```

And then execute:

```bash
bundle install
```

## Usage

Here's an example of using it in a Rails application:

```ruby
# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :instagram, ENV['INSTAGRAM_CLIENT_ID'], ENV['INSTAGRAM_CLIENT_SECRET']
end
```

Make sure to set `INSTAGRAM_CLIENT_ID` and `INSTAGRAM_CLIENT_SECRET` environment variables to your actual credentials or use [Rails encrypted credentials](https://guides.rubyonrails.org/security.html#custom-credentials) (e.g. `Rails.application.credentials.instagram`).


## Scopes

The default scope for this strategy is `instagram_business_basic`. To add more scopes simply specify them after your credentials:

```ruby
# config/initializers/omniauth.rb
Rails.application.config.middleware.use OmniAuth::Builder do
  provider :instagram, ENV['INSTAGRAM_CLIENT_ID'], ENV['INSTAGRAM_CLIENT_SECRET'],
    scope: [
        'instagram_business_basic',
        'instagram_business_content_publish',
        'instagram_business_manage_messages',
        'instagram_business_manage_comments',
    ].join(",")
end
```

## Auth Hash

This is an example of what the [Auth Hash](https://github.com/omniauth/omniauth/wiki/Auth-Hash-Schema) available in `request.env['omniauth.auth']` would look like:

```ruby
{
  provider: 'instagram',
  uid: '1234567890',
  info: {
    name: "John Doe",
    nickname: "johndoe",
    image: "https://scontent-nrt1-1.cdninstagram.com/v/..."
  },
  credentials: {
    token: 'qwertyuiopasdfghjklzxcvbnm',
    expires: true,
    expires_at: 1733140352,
  },
  extra: {
    raw_info: {
      id: "987654321",
      name: "John Doe",
      user_id: "1234567890",
      username: "johndoe",
      media_count: 1,
      account_type: "BUSINESS",
      follows_count: 42,
      followers_count: 42,
      profile_picture_url: "https://scontent-nrt1-1.cdninstagram.com/v/..."
    }
  }
}
```

The token stored in the `credentials` lasts for 60 days and can be [refreshed](https://developers.facebook.com/docs/instagram-platform/instagram-api-with-instagram-login/business-login).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).