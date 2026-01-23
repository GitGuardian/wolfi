# fluent-bit

Fluent Bit is a lightweight and high performance log processor.

## Versions

| 📌 Version    | ⬇️ Pull URL                                        | Support |
| ------------ | ------------------------------------------------- | ------- |
| latest       | ghcr.io/gitguardian/wolfi/fluent-bit:latest       | ✅       |
| latest-shell | ghcr.io/gitguardian/wolfi/fluent-bit:latest-shell | ✅       |
| 4.2          | ghcr.io/gitguardian/wolfi/fluent-bit:4.2          | ✅       |
| 4.2-shell    | ghcr.io/gitguardian/wolfi/fluent-bit:4.2-shell    | ✅       |
| 4.2.2        | ghcr.io/gitguardian/wolfi/fluent-bit:4.2.2        | ✅       |
| 4.2.2-shell  | ghcr.io/gitguardian/wolfi/fluent-bit:4.2.2-shell  | ✅       |
| 4.0          | ghcr.io/gitguardian/wolfi/fluent-bit:4.0          | ✅       |
| 4.0-shell    | ghcr.io/gitguardian/wolfi/fluent-bit:4.0-shell    | ✅       |
| 4.0.3        | ghcr.io/gitguardian/wolfi/fluent-bit:4.0.3        | ✅       |
| 4.0.3-shell  | ghcr.io/gitguardian/wolfi/fluent-bit:4.0.3-shell  | ✅       |
| 4.0.2        | ghcr.io/gitguardian/wolfi/fluent-bit:4.0.2        | ✅       |
| 4.0.2-shell  | ghcr.io/gitguardian/wolfi/fluent-bit:4.0.2-shell  | ✅       |
| 4.0.0        | ghcr.io/gitguardian/wolfi/fluent-bit:4.0.0        | ✅       |
| 4.0.0-shell  | ghcr.io/gitguardian/wolfi/fluent-bit:4.0.0-shell  | ✅       |
| 3.2          | ghcr.io/gitguardian/wolfi/fluent-bit:3.2          | ❌       |
| 3.2-shell    | ghcr.io/gitguardian/wolfi/fluent-bit:3.2-shell    | ❌       |

## ✅ Verify the Provenance

GitHub CLI ([gh](https://cli.github.com/)) can be used to retrieve the build provenance, which details the exact commit, workflow, and runner that produced the image:

- **Production image**

```shell
gh attestation verify \
  --owner gitguardian \
  oci://ghcr.io/gitguardian/wolfi/fluent-bit:latest
```

- **Shell image**

```shell
gh attestation verify \
  --owner gitguardian \
  oci://ghcr.io/gitguardian/wolfi/fluent-bit:latest-shell
```

## 📦 **Image Verification**

All official images are **cryptographically signed** using [Sigstore Cosign](https://www.sigstore.dev/).

### ✅ Verify the Image Signature

To ensure the image is authentic and has not been tampered with, use the following command:

- **Production image**

```shell
cosign verify \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/fluent-bit:latest | jq
```

- **Shell image**

```shell
cosign verify \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/fluent-bit:latest-shell | jq
```

### 📦 **Image SBOMs**

To enhance transparency, we generate SBOMs for each release. SBOMs are available directly from the container registry
and can be verified using using [Sigstore Cosign](https://www.sigstore.dev/).

#### ✅ Verify the Image Attestations

- **Production image**

```shell
cosign verify-attestation \
  --type=https://spdx.dev/Document \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/fluent-bit:latest
```

- **Shell image**

```shell
cosign verify-attestation \
  --type=https://spdx.dev/Document \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/fluent-bit:latest-shell
```

This will pull in the signature for the attestation specified by the --type parameter, which in this case is the SPDX attestation. You will receive output that verifies the SBOM attestation signature in cosign's transparency log:

```shell
Verification for ghcr.io/gitguardian/wolfi/fluent-bit:latest --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - Existence of the claims in the transparency log was verified offline
  - The code-signing certificate was verified using trusted certificate authority certificates
Certificate subject: https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main
Certificate issuer URL: https://token.actions.githubusercontent.com
GitHub Workflow Trigger: push
GitHub Workflow SHA: ced6b3cfab1341509de55bff7c0389ce81f73aae
GitHub Workflow Name: python
GitHub Workflow Repository: GitGuardian/wolfi
GitHub Workflow Ref: refs/heads/main
...
```

#### ✅ Download the Image SBOM Attestations

To download an attestation, use the `cosign` download attestation command and provide both the predicate type and the build platform. For example, the following command will obtain the SBOM for the python image on `linux/amd64`:

- **Production image**

```shell
cosign download attestation \
  --platform=linux/amd64 \
  --predicate-type=https://spdx.dev/Document \
  ghcr.io/gitguardian/wolfi/fluent-bit:latest | jq -r .payload | base64 -d | jq .predicate
```

- **Shell image**

```shell
cosign download attestation \
  --platform=linux/amd64 \
  --predicate-type=https://spdx.dev/Document \
  ghcr.io/gitguardian/wolfi/fluent-bit:latest-shell | jq -r .payload | base64 -d | jq .predicate
```
