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
| [bash](./images/bash/)                                         | `docker pull ghcr.io/gitguardian/wolfi/bash`                     |
| [fluent-bit](./images/fluent-bit/)                             | `docker pull ghcr.io/gitguardian/wolfi/fluent-bit`               |
| [ggshield](./images/ggshield/)                                 | `docker pull ghcr.io/gitguardian/wolfi/ggshield`                 |
| [helm](./images/helm/)                                         | `docker pull ghcr.io/gitguardian/wolfi/helm`                     |
| [infra-tools](./images/infra-tools/)                           | `docker pull ghcr.io/gitguardian/wolfi/infra-tools`              |
| [ingress-nginx-controller](./images/ingress-nginx-controller/) | `docker pull ghcr.io/gitguardian/wolfi/ingress-nginx-controller` |
| [istio-proxy](./images/istio-proxy/)                           | `docker pull ghcr.io/gitguardian/wolfi/istio-proxy`              |
| [loki](./images/loki/)                                         | `docker pull ghcr.io/gitguardian/wolfi/loki`                     |
| [minio-bitnami](./images/minio-bitnami/)                       | `docker pull ghcr.io/gitguardian/wolfi/minio-bitnami`            |
| [nginx](./images/nginx/)                                       | `docker pull ghcr.io/gitguardian/wolfi/nginx`                    |
| [node](./images/node/)                                         | `docker pull ghcr.io/gitguardian/wolfi/node`                     |
| [pgvector-bitnami](./images/pgvector-bitnami/)                 | `docker pull ghcr.io/gitguardian/wolfi/pgvector-bitnami`         |
| [prometheus](./images/prometheus/)                             | `docker pull ghcr.io/gitguardian/wolfi/prometheus`               |
| [prometheus-adapter](./images/prometheus-adapter/)             | `docker pull ghcr.io/gitguardian/wolfi/prometheus-adapter`       |
| [python](./images/python/)                                     | `docker pull ghcr.io/gitguardian/wolfi/python`                   |
| [python-gitguardian](./images/python-gitguardian/)             | `docker pull ghcr.io/gitguardian/wolfi/python-gitguardian`       |
| [redis-bitnami](./images/redis-bitnami/)                       | `docker pull ghcr.io/gitguardian/wolfi/redis-bitnami`            |
| [shell](./images/shell/)                                       | `docker pull ghcr.io/gitguardian/wolfi/shell`                    |
| [traefik](./images/traefik/)                                   | `docker pull ghcr.io/gitguardian/wolfi/traefik`                  |
