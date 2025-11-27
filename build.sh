#!/usr/bin/env bash
set -euo pipefail

echo "===> Bundle install"
bundle install --without development test

echo "===> Assets precompile"
bundle exec rails assets:precompile

echo "===> DB migrate"
bundle exec rails db:migrate

# 本番で ADMIN_PASSWORD が無い場合は seed を実行せずエラーにする（安全側）
if [ "${RAILS_ENV:-production}" = "production" ]; then
  if [ -z "${ADMIN_PASSWORD:-}" ]; then
    echo "ERROR: ADMIN_PASSWORD is not set in production. Aborting seeds."
    exit 1
  fi
fi

echo "===> DB seed"
bundle exec rails db:seed