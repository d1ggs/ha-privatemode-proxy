# Privatemode Proxy

Runs Privatemode's official encryption proxy inside Home Assistant, so that
Assist can use Privatemode's language models without your requests being
readable by the cloud provider hosting them.

## How it works

[Privatemode](https://www.privatemode.ai) (Edgeless Systems, Germany) runs
open models (GLM, gpt-oss and others) on confidential-computing hardware in
the EU. Before sending anything, the proxy checks the hardware's attestation
(a signed statement from AMD and NVIDIA of what software the server runs) and
encrypts every request so that only that server can read it.

This add-on starts the proxy and keeps your API key inside it. Clients talk
to the proxy with the OpenAI API and use the word `placeholder` as their key;
the proxy replaces it with your real key.

## Setup

1. Get an API key from the [Privatemode portal](https://portal.privatemode.ai).
2. In this add-on's **Configuration** tab, paste the key into **API key**, then start the add-on.
3. Note the add-on's **hostname** on its **Info** tab (it ends in `-privatemode-proxy`).
4. In Home Assistant, add the **llama.cpp** integration (Settings → Devices & services → Add integration):
   - **URL:** `http://<hostname>:8080/v1`
   - **API key:** `placeholder`
   - **Model:** `glm-5.3-flash` (fast, supports tool calling)
   - Enable **Control Home Assistant** (Assist).
5. In Settings → Voice assistants, select the new conversation agent. Turning on
   **Prefer handling commands locally** sends only commands Home Assistant
   cannot handle itself to the model.

Why llama.cpp: it is a built-in integration that accepts any OpenAI-compatible
server address. Home Assistant's OpenAI integration only connects to OpenAI.

## Health

Docker checks `/readyz` every 30 seconds. With **Watchdog** turned on (Info tab), Home Assistant restarts the add-on when the check fails.

## Network

By default the proxy is reachable only from Home Assistant and other add-ons.
To use it from other devices, set a port in the **Network** section. Anyone who
can reach that port can use your API key.

## Updates

The add-on version follows the upstream proxy version. A daily check in this
repository picks up new stable Privatemode releases. The proxy fetches the list
of expected server software from Privatemode at startup and keeps a record of
every version it has seen in `/data/manifests`.

## Licence note

This repository only contains a Dockerfile and a start script. The proxy itself
is Privatemode's official image, downloaded from `ghcr.io/edgelesssys` and
used unmodified.
