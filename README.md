# zemvar runtime assets (Zemvar-Public)

ZEMVAR executor runtime assets + entry script. Mirrors the original Gloop asset pipeline so all fetches land on ZEMVAR-controlled hosting.

## Layout (must stay exactly as-is — paths are hardcoded in `loader/dev_loader.lua` and the native bootstrap)

```
assets/delta/<shortid>    17 icon/font blobs, md5-verified by dev_loader's deltaAssets table
loader/dev_loader.lua     asset loader: fetches assets/delta/* from this repo, caches to ./DeltaAssets/
logo/zemvar_logo.png      ZEMVAR wordmark
scripts/ui/Delta.lua      ENTRY SCRIPT — the native bootstrap (getDownloadUrl) must point here
scripts/input-library.lua virtual input manager library (recovered from Gloop pre-retirement commit d56e0b06035d)
scripts/infiniteyield.lua infiniteyield source (Showcase button fetch; mirrored as repo-retirement insurance)
scripts/deltaMouseAndKeyboard.lua, MobileKeyboard.txt, Loading_UI, ScriptLoad.lua   supporting scripts
```

## Push procedure

1. Empty repo `Zemvar-Public` already exists on github.com under XxEASTRxX (public — client only needs read access to raw files).
2. Push the CONTENTS of this folder as the repo root:
   ```
   cd zemvar-assets
   git init && git add -A && git commit -m "zemvar runtime assets"
   git remote add origin git@github.com:XxEASTRxX/Zemvar-Public.git
   git push -u origin main
   ```
3. Bootstrap URL (target of the libroblox.so string patch):
   `https://raw.githubusercontent.com/XxEASTRxX/Zemvar-Public/main/scripts/ui/Delta.lua`

## Invariants

- Do NOT rename files under `assets/delta/` — shortids are referenced by the oopsie table in dev_loader and md5-gated.
- If an icon is replaced, update its md5 in `loader/dev_loader.lua` deltaAssets (client re-downloads on mismatch).
- Entry script branding: user-visible strings are ZEMVAR; internal `DELTA[...]` identifiers are intentional (renaming risks the instance-tree dump).
