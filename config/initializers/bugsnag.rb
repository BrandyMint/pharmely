require 'semver'

Bugsnag.configure do |config|
  config.api_key = "4f73e9b81fda1fa2e641196a147eae00"
  config.notify_release_stages = ["production", "staging", "preproduction"]
  config.app_version = SemVer.find.to_s
end
