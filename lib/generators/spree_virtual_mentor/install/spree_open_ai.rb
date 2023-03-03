require "openai"

OpenAI.configure do |config|
  config.access_token = 'OPENAI_ACCESS_TOKEN'
  config.organization_id = 'OPENAI_ORGANIZATION_ID' # Optional.
end
