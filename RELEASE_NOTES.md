# Silo 0.4.10

Three controls that were visibly there but did nothing now work.

- **MetalFX upscaling actually engages.** The per-game toggle set the flag, but GPTK ships its DLSS→MetalFX bridge under a name nothing resolves, so there was never a provider behind the switch. Silo now activates that bridge and makes it resolvable inside the bottle.
- **The Sync setting is honoured for non-Steam games.** Their settings sheet offered the picker while every launch forced msync regardless. That rule protects the shared Steam bottle's single connection to the Steam client; a manual game has its own isolated bottle and nothing to protect, so the picker now stands as set. Steam games are unchanged.
- **A game using Wine's virtual desktop gets your display's real resolution.** It was sized at a fixed 1440x900 — the Steam client window's size — so a game falling back to the virtual desktop was capped there and native resolution never appeared in its options. It is now sized to the display in real pixels, on a desktop of its own so it can no longer inherit the client's.

Thanks to [@BananaStems](https://github.com/mikaelhug/Silo/pull/5) for reporting the 1440x900 cap on real hardware.

---

Silo downloads its own Wine (built from CrossOver's FOSS source in CI) and imports Apple's GPTK from your `.dmg`. Runs on macOS 15+ on Apple Silicon. Gatekeeper: the build is ad-hoc signed, so right-click → **Open** on first launch (or `xattr -dr com.apple.quarantine Silo.app`).
