FROM reg.echohq.com/base:builder AS builder

RUN add-pkg -r \
      libstdc++6 python-3.13 ca-certificates \
      curl git-minimal libgcrypt20 libpq5 ripgrep tini \
    && rm -rf /os/usr/share/man /os/usr/share/doc /os/usr/share/info \
    && rm -rf /os/usr/local/lib/python3.13/site-packages/pip* \
              /os/usr/local/lib/python3.13/site-packages/wheel* \
              /os/usr/local/lib/python3.13/site-packages/packaging* \
              /os/usr/local/lib/python3.13/ensurepip \
              /os/usr/local/bin/pip* /os/usr/local/bin/wheel

RUN install -d -o 65532 -g 65532 -m 0755 /os/app /os/resources /os/home/nonroot \
    && install -d -o 65532 -g 65532 -m 0777 /os/cache /os/tmp/prometheus_multiproc_dir

FROM scratch
COPY --from=builder /os/ /

ENV LANG=C.UTF-8 \
    PROMETHEUS_MULTIPROC_DIR=/tmp/prometheus_multiproc_dir

LABEL org.opencontainers.image.title="python-gitguardian" \
      org.opencontainers.image.description="Python image based on Echo Linux for GitGuardian" \
      org.opencontainers.image.source="https://github.com/GitGuardian/wolfi/tree/main/images/python-gitguardian" \
      org.opencontainers.image.licenses="MIT" \
      org.opencontainers.image.vendor="GitGuardian" \
      org.opencontainers.image.authors="GitGuardian SRE Team <sre@gitguardian.com>"

USER nonroot
WORKDIR /home/nonroot
ENTRYPOINT ["/usr/local/bin/python"]
