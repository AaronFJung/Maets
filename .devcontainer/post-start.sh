#!/usr/bin/env bash
set -euo pipefail

print_access_message() {
  echo ""
  echo "============================================================"
  echo "  Supabase is running and available at:"
  echo "    Studio (web portal):  http://localhost:54323"
  echo "    API:                  http://localhost:54321"
  echo "    Web app:              http://localhost:3000  (run "Start Frontend" task)"
  echo ""
  echo "  Run 'supabase status' for keys."
  echo "============================================================"
}

# Idempotent: `supabase status` exits 0 only when the stack is already up.
if supabase status >/dev/null 2>&1; then
  echo "Supabase is already running."
  print_access_message
  exit 0
fi

echo "Starting Supabase (first run pulls several Docker images and can take a few minutes)..."
supabase start
print_access_message
