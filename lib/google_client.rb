require 'signet/oauth_2/client'

module GoogleClient
  @@signet = Signet::OAuth2::Client
  cattr_accessor :signet
  
  def self.redirect_uri
    ENV['GOOGLE_REDIRECT_URI']
  end

  def initialize(user = nil)
    return nil if !user
    @client = signet.new(
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri:  'https://accounts.google.com/o/oauth2/token',
      client_id: ENV['GOOGLE_CLIENT_ID'],
      client_secret: ENV['GOOGLE_CLIENT_SECRET'],
      scope: [
            'profile',
            'email',
            'https://www.googleapis.com/auth/calendar',
          ],
      redirect_uri: ENV['GOOGLE_REDIRECT_URI']
    )
  end

  def add_token(token)
    @client.access_token = token.access_token
    @client.expires_at = token.expires_at
    @client.issued_at = token.updated_at

    if expired?
      raise Errors::TokenExpired
    end
  end

  def client
    @client
  end

  def client_with_token(token)
    add_token(token)
    @client
  end

  private

  def expired?
    Time.zone.now > @client.expires_at
  end
end
