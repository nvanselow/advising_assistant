class FakeSignet
  attr_accessor :access_token, :expires_at, :issued_at

  def initialize(authorization_uri:,
                 token_credential_uri:,
                 client_id:,
                 client_secret:,
                 scope:,
                 redirect_uri:)
  end
end
