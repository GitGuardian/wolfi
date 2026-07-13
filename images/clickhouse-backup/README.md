# clickhouse-backup

Zero-CVE [clickhouse-backup](https://github.com/Altinity/clickhouse-backup) (Altinity) image based on Wolfi OS — the backup/restore sidecar for our self-hosted ClickHouse deployment (tiered S3/Azure/GCS object storage). Default command is `server` (REST API + `--watch` mode).

## Versions

| Version        | Pull URL                                                    |
| -------------- | ----------------------------------------------------------- |
| latest         | ghcr.io/gitguardian/wolfi/clickhouse-backup:latest          |
| latest-shell   | ghcr.io/gitguardian/wolfi/clickhouse-backup:latest-shell    |
| 2.7.4          | ghcr.io/gitguardian/wolfi/clickhouse-backup:2.7.4           |
| 2.7.4-shell    | ghcr.io/gitguardian/wolfi/clickhouse-backup:2.7.4-shell     |

The `shell` variant adds `bash`, `busybox`, `curl`, `openssl`, and `wget` for debugging (e.g. checking object-storage reachability); the `prod` variant is minimal and runs as non-root.

## Verify the Provenance

GitHub CLI ([gh](https://cli.github.com/)) can be used to retrieve the build provenance, which details the exact commit, workflow, and runner that produced the image:

- **Production image**

```shell
gh attestation verify \
  --owner gitguardian \
  oci://ghcr.io/gitguardian/wolfi/clickhouse-backup:latest
```

- **Shell image**

```shell
gh attestation verify \
  --owner gitguardian \
  oci://ghcr.io/gitguardian/wolfi/clickhouse-backup:latest-shell
```

## Image Verification

All official images are **cryptographically signed** using [Sigstore Cosign](https://www.sigstore.dev/).

### Verify the Image Signature

To ensure the image is authentic and has not been tampered with, use the following command:

- **Production image**

```shell
cosign verify \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/clickhouse-backup:latest | jq
```

- **Shell image**

```shell
cosign verify \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/clickhouse-backup:latest-shell | jq
```

### Image SBOMs

To enhance transparency, we generate SBOMs for each release. SBOMs are available directly from the container registry and can be verified using [Sigstore Cosign](https://www.sigstore.dev/).

#### Verify the Image Attestations

- **Production image**

```shell
cosign verify-attestation \
  --type=https://spdx.dev/Document \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/clickhouse-backup:latest
```

- **Shell image**

```shell
cosign verify-attestation \
  --type=https://spdx.dev/Document \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/clickhouse-backup:latest-shell
```

#### Download the Image SBOM Attestations

To download an attestation, use the `cosign` download attestation command and provide both the predicate type and the build platform. For example, the following command will obtain the SBOM for the clickhouse-backup image on `linux/amd64`:

- **Production image**

```shell
cosign download attestation \
  --platform=linux/amd64 \
  --predicate-type=https://spdx.dev/Document \
  ghcr.io/gitguardian/wolfi/clickhouse-backup:latest | jq -r .payload | base64 -d | jq .predicate
```

- **Shell image**

```shell
cosign download attestation \
  --platform=linux/amd64 \
  --predicate-type=https://spdx.dev/Document \
  ghcr.io/gitguardian/wolfi/clickhouse-backup:latest-shell | jq -r .payload | base64 -d | jq .predicate
```
