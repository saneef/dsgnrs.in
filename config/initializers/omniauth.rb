Rails.application.config.middleware.use OmniAuth::Builder do
  provider :twitter, ENV['TWITTER_CONSUMER_KEY'], ENV['TWITTER_CONSUMER_SECRET']
end

class SafeFailureEndpoint < OmniAuth::FailureEndpoint
  def call
    redirect_to_failure
  end
end

OmniAuth.config.on_failure = SafeFailureEndpoint