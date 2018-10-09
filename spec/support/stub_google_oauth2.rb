# frozen_string_literal: true

module StubGoogleOauth2
  def stub_env_for_omniauth
    request.env["devise.mapping"] = Devise.mappings[:user]

    request.env["omniauth.auth"] = OmniAuth::AuthHash.new({
      "provider"=>"google_oauth2",
      "uid"=>uid,
      "info"=>{
        "email" => "example@xyze.it",
        "name" => "Test User",
        "image" => "..."
      }
    })
  end
end