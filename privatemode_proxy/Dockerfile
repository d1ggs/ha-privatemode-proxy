# The proxy image is Privatemode's official build, used unmodified.
# PROXY_VERSION is bumped automatically by .github/workflows/bump.yml.
ARG PROXY_VERSION=v1.61.0

# Statically linked BusyBox, only used by run.sh to read the add-on options.
FROM busybox:musl AS busybox

FROM ghcr.io/edgelesssys/privatemode/privatemode-proxy:${PROXY_VERSION}
COPY --from=busybox /bin/busybox /usr/local/bin/busybox
COPY run.sh /run.sh

# /readyz answers 204 once the proxy has verified the server and is ready.
HEALTHCHECK --interval=30s --timeout=10s --start-period=60s --retries=3 \
    CMD ["/usr/local/bin/busybox", "wget", "-q", "-O", "/dev/null", "http://127.0.0.1:8080/readyz"]
ENTRYPOINT ["/usr/local/bin/busybox", "sh", "/run.sh"]
