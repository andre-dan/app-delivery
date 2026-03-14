#!/usr/bin/env bash
# Render.com build script — chamado automaticamente no deploy
set -o errexit

echo "==> bundle install"
bundle install

echo "==> db:migrate"
bin/rails db:migrate

echo "==> db:seed (ignora erro se já populado)"
bin/rails db:seed || true

echo "==> Build concluído"
