# The proxy image is Privatemode's official build, used unmodified.
# PROXY_VERSION is bumped automatically by .github/workflows/bump.yml.
ARG PROXY_VERSION=v1.61.0

# Statically linked BusyBox, only used by run.sh to read the add-on options.
FROM busybox:musl AS busybox

FROM ghcr.io/edgelesssys/privatemode/privatemode-proxy:${PROXY_VERSION}
COPY --from=busybox /bin/busybox /usr/local/bin/busybox
COPY run.sh /run.sh
ENTRYPOINT ["/usr/local/bin/busybox", "sh", "/run.sh"]
