# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

# db/seeds.rb
def upsert_user!(email:, name:, admin:, password:)
  user = User.find_or_initialize_by(email: email)
  user.name = name
  user.admin = admin
  user.password = password
  user.password_confirmation = password
  user.save!
  puts "Upserted: #{email}"
end

# Admin（本番・開発共通）
admin_email    = ENV.fetch("ADMIN_EMAIL", "admin@example.com")
admin_password = ENV.fetch("ADMIN_PASSWORD", "testuser")
upsert_user!(email: admin_email, name: "adminuser", admin: true, password: admin_password)

# 開発専用テストユーザー
if Rails.env.development?
  dev_pw = ENV.fetch("DEV_USER_PASSWORD", "testuser")
  upsert_user!(email: "test@example.com",  name: "testuser",  admin: false, password: dev_pw)
  upsert_user!(email: "test2@example.com", name: "testuser2", admin: false, password: dev_pw)
end