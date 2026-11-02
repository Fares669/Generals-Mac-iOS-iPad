#!/usr/bin/env bash
# Create a sideloadable (after signing) IPA from the assembled iOS app.
set -euo pipefail
ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"
APP="${1:-$ROOT/build/ios-package/GeneralsXZH.app}"
OUT="${2:-$ROOT/build/GeneralsXZH-lite-unsigned.ipa}"
[[ -d "$APP" ]] || { echo "Missing .app: $APP" >&2; exit 1; }
[[ -f "$APP/GeneralsXZH" ]] || { echo "Missing game executable" >&2; exit 1; }
[[ -d "$APP/Frameworks/MoltenVK.framework" ]] || { echo "Missing MoltenVK runtime" >&2; exit 1; }
mkdir -p "$(dirname "$OUT")"
TMP="$(mktemp -d)"
trap 'rm -rf "$TMP"' EXIT
mkdir -p "$TMP/Payload"
ditto "$APP" "$TMP/Payload/GeneralsXZH.app"
# Remove developer provisioning; sideload software must re-sign the app.
rm -f "$TMP/Payload/GeneralsXZH.app/embedded.mobileprovision"
find "$TMP/Payload/GeneralsXZH.app" -name _CodeSignature -type d -prune -exec rm -rf {} +
(cd "$TMP" && zip -qry "$OUT" Payload)
unzip -tqq "$OUT"
echo "IPA created: $OUT"
echo "Unsigned: sign with an Apple developer identity or a sideloading tool before installation."
