#!/usr/bin/env bash
# Download the last three Sonic releases' APKs into repo/, each checked against its .sha256,
# and the newest release's store listing (fastlane metadata) into metadata/app.sonic/.
set -euo pipefail
SRC=Abhiroop1122/Sonic
mkdir -p repo metadata/app.sonic
tags=$(gh release list --repo "$SRC" --exclude-pre-releases --exclude-drafts --limit 3 --json tagName -q '.[].tagName')
for tag in $tags; do
  v=${tag#v}
  [ -f "repo/Sonic-$v.apk" ] && continue
  tmp=$(mktemp -d)
  gh release download "$tag" --repo "$SRC" --dir "$tmp" --pattern "Sonic-$v.apk" --pattern "Sonic-$v.apk.sha256"
  (cd "$tmp" && sha256sum -c "Sonic-$v.apk.sha256")
  mv "$tmp/Sonic-$v.apk" repo/
done
newest=$(echo "$tags" | sed -n 1p)
curl -fsSL "https://codeload.github.com/$SRC/tar.gz/refs/tags/$newest" \
  | tar -xz --strip-components=4 -C metadata/app.sonic --wildcards '*/fastlane/metadata/android/*'
ls repo metadata/app.sonic
