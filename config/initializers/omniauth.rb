Rails.application.config.middleware.use OmniAuth::Builder do
  provider :google_oauth2, ENV['GOOGLE_CLIENT_ID'], ENV['GOOGLE_CLIENT_SECRET'], {
    scope: [
        'profile',
        'email',
        'https://www.googleapis.com/auth/calendar'
      ],
      access_type: 'offline',
      approval_prompt: 'force'
  }
end
