# MacOS Developer Setup

ARCHIVED:
Brew is a shitcoin.
Moved to Nix.
Check: [`realeinherjar/flakes-darwin`](https://github.com/realeinherjar/flakes-darwin).

Just run `make install` and profit!

> Don't forget to check the [MacOS Hardening Guide](https://github.com/ataumo/macos_hardening)
> and the [MacOS Security and Privacy Guide](https://github.com/drduh/macOS-Security-and-Privacy-Guide).

As a caveat, don't register an Apple ID.
You don't need that for apps, just use [Homebrew](https://brew.sh).

1. Enable Filevault (disk encryption) and back up the key: System Settings > Privacy & Security > FileVault
1. Enable Lockdown Mode
1. Enable Dark Mode
1. Enable Firewall: Network > Firewall: Enable Firewall
1. Disable all Sharing stuff: General > Sharing: Disable All
1. Disable Notifications previews:
   - Notifications > Show Previews: Never
   - Notifications: Disable "Allow notifications when the screen is locked"
   - Lock Screen > Require password immediately
1. Change NTP Server: General > Date & Time > Source: Change to "pool.ntp.org"
1. Set the smart battery saver: Boost mode on AC and Low Power mode on battery
1. Change DNS
   - Select connection (Wi-Fi or Ethernet) and click "Details"
   - Disable "Limit IP address tracking"
   - Click "DNS"
   - 1.1.1.1 and 1.0.0.1 (Cloudflare)
1. Disable Siri:
   - Siri and Spotlight: Disable "Ask Siri"
   - Siri and Spotlight > Siri Suggestions > Disable all
1. Disable Analytics:
   - Privacy and Security > Analytics > Improvements: Disable all
   - Privacy and Security > Apple Advertising > Disable personalized ads
   - Game Center: Disable all

## FAQ

- My tmux is getting `WARNING: terminal is not fully functional`.
   > Follow the instructions [here](https://gist.github.com/nicm/ea9cf3c93f22e0246ec858122d9abea1)
   > and [here](https://github.com/tmux/tmux/issues/2262).

## TODO

- Redo configs with Nix Darwin like <https://github.com/dustinlyons/nixos-config>.
