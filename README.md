# Privatemode Proxy add-on for Home Assistant

Use [Privatemode](https://www.privatemode.ai)'s EU-hosted, end-to-end encrypted
language models as a Home Assistant Assist conversation agent.

The add-on runs Privatemode's official proxy, which verifies the remote
hardware and encrypts each request so that only the attested server can read
it. Home Assistant connects to it through the built-in **llama.cpp**
integration, so no custom integration is needed.

## Install

[![Add repository](https://my.home-assistant.io/badges/supervisor_add_addon_repository.svg)](https://my.home-assistant.io/redirect/supervisor_add_addon_repository/?repository_url=https%3A%2F%2Fgithub.com%2Fd1ggs%2Fha-privatemode-proxy)

Or add `https://github.com/d1ggs/ha-privatemode-proxy` under Settings → Add-ons
→ Add-on store → ⋮ → Repositories, then install **Privatemode Proxy**.

Setup steps are in [privatemode_proxy/DOCS.md](privatemode_proxy/DOCS.md).

## Versions

The add-on version matches the [upstream proxy release](https://github.com/edgelesssys/privatemode-public/releases).
A scheduled workflow checks daily for a new stable release, updates the
Dockerfile and version, and tags the commit. Enable auto-update on the add-on
to always run the latest version.

## Contributing

Issues and pull requests are welcome. The image is built by the Home Assistant
Supervisor on your device; this repository does not publish images.

## Licence

MIT for the files in this repository. The Privatemode proxy is © Edgeless
Systems GmbH and is downloaded from its official registry.
