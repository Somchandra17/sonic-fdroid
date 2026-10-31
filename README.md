# Sonic. F-Droid repository

An F-Droid repository for [Sonic.](https://github.com/Abhiroop1122/Sonic), serving the exact APKs from its GitHub releases. Nothing is rebuilt, so an install from here and one from GitHub update each other.

**Add it:** open https://somchandra17.github.io/sonic-fdroid on your phone and tap *Add to F-Droid*, or add this by hand in F-Droid, Droid-ify or Neo Store:

```
https://somchandra17.github.io/sonic-fdroid/repo
Fingerprint: C482BF3B0848C66DD63E0194711A3DC800487D908D6008A66A124B7E16A91E6B
```

## How it updates

`.github/workflows/update.yml` checks every hour whether Sonic has a release this repository doesn't serve yet, and publishes only then (a push or a run from the Actions tab always publishes):

1. `scripts/fetch.sh` downloads the last three Sonic releases' APKs, each checked against its `.sha256`, and the newest release's store listing from its `fastlane/` folder.
2. `fdroid update` writes the index and signs it with the repository key (the `KEYSTORE_B64`, `KEYSTOREPASS` and `KEYPASS` secrets).
3. The result goes to GitHub Pages.

GitHub switches a public repository's schedule off after 60 days without activity, so the workflow makes an empty "keepalive" commit when the repository has been quiet for 45 days.

The repository key signs only the index, not the app. Keep a copy of it: losing it means everyone has to add the repository again.
