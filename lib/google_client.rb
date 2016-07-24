require 'signet/oauth_2/client'

module GoogleClient
  def self.redirect_uri
    ENV['GOOGLE_REDIRECT_URI']
  end

  def initialize(user = nil)
    return nil if !user
    @client = Signet::OAuth2::Client.new(
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
    binding.pry
    @client.access_token = token.access_token
    @client.expires_at = token.expires_at
    @client.issued_at = token.updated_at
  end

  def client
    @client
  end

  def client_with_token(token)
    add_token(token)
    @client
  end
end
