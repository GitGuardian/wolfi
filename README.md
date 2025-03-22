# Wolfi Base images by GitGuardian

[![License](https://img.shields.io/github/license/GitGuardian/wolfi)](LICENSE)

## Overview

**GitGuardian/Wolfi** is a repository providing a set of **lightweight and secure** container images based on the [Wolfi](https://wolfi.dev/) Linux distribution. These images are designed for security-focused applications, offering a minimal attack surface while ensuring compatibility with modern containerized workloads.

## Features

- **Minimalist & Secure**: Built from scratch using [apko](https://github.com/chainguard-dev/apko) with a focus on security and small footprint.
- **Continuous Updates**: Regularly updated with the latest security patches.
- **Compatibility**: Optimized for OCI-compliant runtime environments.
- **Reproducible Builds**: Ensuring consistency across deployments.
- **Provenance & Security**: All images are signed and come with attestations for enhanced security and trust.

## Available Images

| Image Name                                                     | Pull                                                             |
| -------------------------------------------------------------- | ---------------------------------------------------------------- |
| [apache-tika](./images/apache-tika/)                           | `docker pull ghcr.io/gitguardian/wolfi/apache-tika`              |
| [fluent-bit](./images/fluent-bit/)                             | `docker pull ghcr.io/gitguardian/wolfi/fluent-bit`               |
| [helm](./images/helm/)                                         | `docker pull ghcr.io/gitguardian/wolfi/helm`                     |
| [ingress-nginx-controller](./images/ingress-nginx-controller/) | `docker pull ghcr.io/gitguardian/wolfi/ingress-nginx-controller` |
| [loki](./images/loki/)                                         | `docker pull ghcr.io/gitguardian/wolfi/loki`                     |
| [minio](./images/loki/)                                        | `docker pull ghcr.io/gitguardian/wolfi/minio`                    |
| [minio-bitnami](./images/minio-bitnami/)                       | `docker pull ghcr.io/gitguardian/wolfi/minio-bitnami`            |
| [minio-bitnami-client](./images/minio-bitnami-client/)         | `docker pull ghcr.io/gitguardian/wolfi/minio-bitnami-client`     |
| [nginx](./images/nginx/)                                       | `docker pull ghcr.io/gitguardian/wolfi/nginx`                    |
| [postgres-bitnami](./images/postgres-bitnami/)                 | `docker pull ghcr.io/gitguardian/wolfi/postgres-bitnami`         |
| [prometheus](./images/prometheus/)                             | `docker pull ghcr.io/gitguardian/wolfi/prometheus`               |
| [prometheus-adapter](./images/prometheus-adapter/)             | `docker pull ghcr.io/gitguardian/wolfi/prometheus-adapter`       |
| [python](./images/python/)                                     | `docker pull ghcr.io/gitguardian/wolfi/python`                   |
| [python-gitguardian](./images/python-gitguardian/)             | `docker pull ghcr.io/gitguardian/wolfi/python-gitguardian`       |
| [redis-sentinel-bitnami](./images/redis-sentinel-bitnami/)     | `docker pull ghcr.io/gitguardian/wolfi/redis-sentinel-bitnami`   |
| [redis-server-bitnami](./images/redis-server-bitnami/)         | `docker pull ghcr.io/gitguardian/wolfi/redis-server-bitnami`     |
| [traefik](./images/traefik/)                                   | `docker pull ghcr.io/gitguardian/wolfi/traefik`                  |
