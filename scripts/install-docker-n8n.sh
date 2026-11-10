#!/usr/bin/env bash
# install-docker-n8n.sh — Ai Mindset: AWS Lightsail VPS + Docker + n8n
# ----------------------------------------------------------------------
# မြန်မာ: ဒီ script ကို Ubuntu 24.04 LTS Lightsail VPS (n8n-sydney) မှာ run ပါ။
#   ssh ubuntu@<YOUR_VPS_IP> နဲ့ ဝင်ပြီး `bash install-docker-n8n.sh` လို့ run ပါ။
# English: Run this on an Ubuntu 24.04 LTS Lightsail VPS as user `ubuntu`.
#   ssh ubuntu@<YOUR_VPS_IP>, then `bash install-docker-n8n.sh`.
#
# What it does / ဘာလုပ်သလဲ:
#   1. Ubuntu update (111 packages in Ko's real run, 2026-11-10)
#   2. 2 GB swap file (the $12/mo plan has only 2 GB RAM)
#   3. Docker via the official Docker install script (verified: Docker 29.9.3)
#   4. n8n 2.46.7 in Docker (SQLite, volume n8n_data, restart unless-stopped,
#      bound to 127.0.0.1:5678 only — Caddy in front does HTTPS)
#
# ⚠️ SECURITY — လုံခြုံရေး:
#   - NEVER set N8N_SECURE_COOKIE=false. (ဘယ်တော့မှ မထည့်ပါနဲ့။)
#     With HTTPS via Caddy the secure cookie works correctly.
#   - This script contains NO token, password, API key or secret.
#     The n8n owner account is created by YOU in the browser afterwards.
#   - Never paste tokens/secrets into chat or screenshots.
#
# Tested on / စမ်းသပ်ပြီး:
#   Lightsail n8n-sydney, Ubuntu 24.04 LTS, Sydney ap-southeast-2a,
#   2 GB RAM / 2 vCPUs / 60 GB SSD, static IP 16.178.116.222,
#   domain n8n.komoe.org, Docker 29.9.3, n8n 2.46.7.
#   Official full n8n stack needs 4 GB RAM — 2 GB works for
#   testing / light use with SQLite + swap only.
set -euo pipefail

echo "==> 1/4 Ubuntu update..."
sudo apt-get update -y
sudo DEBIAN_FRONTEND=noninteractive apt-get upgrade -y
# NOTE: a new kernel may be installed (Ko's run: 7.0.0-1017-aws).
# Reboot later when convenient:  sudo reboot
# (လိုအပ်ရင် နောက်မှ reboot လုပ်ပါ — n8n container က auto-restart ဖြစ်ပါတယ်။)

echo "==> 2/4 2 GB swap..."
if ! swapon --show | grep -q /swapfile; then
  sudo fallocate -l 2G /swapfile
  sudo chmod 600 /swapfile
  sudo mkswap /swapfile
  sudo swapon /swapfile
  echo '/swapfile none swap sw 0 0' | sudo tee -a /etc/fstab
else
  echo "Swap already enabled, skipping."
fi
free -h

echo "==> 3/4 Docker (official install script)..."
if ! command -v docker >/dev/null 2>&1; then
  curl -fsSL https://get.docker.com -o get-docker.sh
  sudo sh get-docker.sh
  rm -f get-docker.sh
  sudo usermod -aG docker "$USER"
else
  echo "Docker already installed, skipping."
fi
docker --version   # expected: Docker version 29.9.3 (or newer)

echo "==> 4/4 n8n 2.46.7 (SQLite, localhost only, behind Caddy)..."
# Stop/remove any previous container with the same name (safe re-run).
docker rm -f n8n 2>/dev/null || true
docker run -d \
  --name n8n \
  --restart unless-stopped \
  -p 127.0.0.1:5678:5678 \
  -v n8n_data:/home/node/.n8n \
  -e N8N_HOST=n8n.komoe.org \
  -e WEBHOOK_URL=https://n8n.komoe.org/ \
  -e N8N_WEBHOOK_URL=https://n8n.komoe.org/ \
  -e N8N_PROTOCOL=https \
  -e TZ=Asia/Rangoon \
  -e GENERIC_TIMEZONE=Asia/Rangoon \
  n8nio/n8n:2.46.7

sleep 5
echo "==> Check: (VPS အတွင်းကနေ စစ်ပါ)"
curl -s -o /dev/null -w "http://127.0.0.1:5678 -> HTTP %{http_code}\n" http://127.0.0.1:5678/
docker ps --filter name=n8n --format '{{.Names}} {{.Status}} {{.Image}}'
echo
echo "DONE ✅  Next steps / နောက်အဆင့်:"
echo "  1. Point your domain at the VPS (Cloudflare DNS A record, DNS only):"
echo "       n8n.komoe.org  ->  <YOUR_VPS_IP>"
echo "  2. Install Caddy (see Caddyfile in this repo) for automatic HTTPS."
echo "  3. Open https://n8n.komoe.org/setup in YOUR browser and create"
echo "     the n8n owner account yourself. Do not share the password."
