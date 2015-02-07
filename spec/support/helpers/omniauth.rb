module Omniauth
  module Mock
    # rubocop: disable Style/NumericLiterals, Metrics/MethodLength
    def auth_mock
      OmniAuth.config.mock_auth[:memberful] = OmniAuth::AuthHash.new(
        "provider" => "memberful",
        "uid" => 56586,
        "info" => {
          "nickname" => "rossta",
          "email" => "rossta@example.com",
          "first_name" => "Ross",
          "last_name" => "Kaffenberger",
          "full_name" => "Ross Kaffenberger"
        },
        "credentials" => {
          "token" => "aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa",
          "refresh_token" => "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb",
          "expires_at" => 1423245169,
          "expires" => true
        },
        "extra" => {
          "raw_info" => {
            "id" => 98765,
            "username" => "rossta",
            "email" => "rossta@example.com",
            "first_name" => "Ross",
            "last_name" => "Kaffenberger",
            "full_name" => "Ross Kaffenberger",
            "unrestricted_access" => false,
            "created_at" => 1423242398
          }
        }
      )
    end
    # rubocop: enable Style/NumericLiterals, Metrics/MethodLength
  end

  module SessionHelpers
    def signin
      visit root_path
      expect(page).to have_content("Sign in")
      auth_mock
      click_link "Sign in"
    end
  end
end
