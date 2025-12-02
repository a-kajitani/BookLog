// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import "@hotwired/turbo-rails"
import "controllers"
import "custom/flash"
import "./custom/markdown_preview_server"
import Rails from "@rails/ujs"
Rails.start()
