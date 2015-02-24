# This file is used by Rack-based servers to start the application.

require ::File.expand_path('../config/environment', __FILE__)

# Добавляем Content-Type для запросов из 1С 7.7

use Rack::AddContentType
run Rails.application
