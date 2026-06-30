#!/usr/bin/env bash
set -euo pipefail

# 1. next/node_modules and next/.next are container-only Docker volumes (see devcontainer.json)
#    so the Linux container never shares them with the Windows host. Fresh volumes are
#    created root-owned, so hand them to the 'node' user before installing.
sudo chown node:node next/node_modules next/.next

# 2. Install the Next.js app's dependencies. `npm ci` does a clean, exact install
#    from the committed package-lock.json, so every teammate gets identical deps.
cd ./next
npm ci
cd ..

# 4. Seed the frontend env file so the app connects out of the box.
#    -n (no-clobber) means an existing .env.local is left untouched.
cp -n next/.env.example next/.env.local 2>/dev/null || true

echo "post-create complete."
