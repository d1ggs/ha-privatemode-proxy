# Starts the Privatemode proxy with the API key from the add-on options.
# Runs under BusyBox sh (the upstream image has no shell).
set -eu
bb=/usr/local/bin/busybox

# Supervisor writes the add-on options as JSON. The key is a single
# string of letters, digits and dashes, so a plain pattern match is enough.
key=$($bb sed -n 's/.*"api_key"[[:space:]]*:[[:space:]]*"\([^"]*\)".*/\1/p' /data/options.json)
if [ -z "$key" ]; then
    echo "No API key set: open the add-on Configuration tab and enter your Privatemode API key." >&2
    exit 1
fi

# Keep the key in a file readable only by this container, never on the command line.
umask 077
$bb mkdir -p /tmp/privatemode
printf '%s' "$key" > /tmp/privatemode/api-key
unset key

exec /bin/privatemode-proxy \
    --api-key @/tmp/privatemode/api-key \
    --api-key-fallback if-placeholder \
    --listen-address 0.0.0.0 \
    --port 8080 \
    --workspace /data \
    --disable-prompt-cache=false
