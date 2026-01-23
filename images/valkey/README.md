# Valkey

Minimal Python image based on Wolfi.

## Versions

| 📌 Version  | ⬇️ Pull URL                                  |
| ---------- | --------------------------------------------- |
| latest     | ghcr.io/gitguardian/wolfi/valkey:latest       |
| latest-dev | ghcr.io/gitguardian/wolfi/valkey:latest-dev   |
| 9.0        | ghcr.io/gitguardian/wolfi/valkey:9.0          |
| 9.0-dev    | ghcr.io/gitguardian/wolfi/valkey:9.0-dev      |
| 8.1        | ghcr.io/gitguardian/wolfi/valkey:8.1          |
| 8.1-dev    | ghcr.io/gitguardian/wolfi/valkey:8.1-dev      |


## ✅ Verify the Provenance

```shell
gh attestation verify \
  --owner gitguardian \
  oci://ghcr.io/gitguardian/wolfi/valkey:latest
```

- **Shell image**

```shell
gh attestation verify \
  --owner gitguardian \
  oci://ghcr.io/gitguardian/wolfi/valkey:latest-shell
```

## 📦 **Image Verification**
cosign verify \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/valkey:latest | jq
```

- **Shell image**
cosign verify \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/valkey:latest-shell | jq
```

### 📦 **Image SBOMs**
  --type=https://spdx.dev/Document \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/valkey:latest
```

- **Shell image**
  --type=https://spdx.dev/Document \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/valkey:latest-shell
```

This will pull in the signature for the attestation specified by the --type parameter, which in this case is the SPDX attestation. You will receive output that verifies the SBOM attestation signature in cosign's transparency log:

```shell
Verification for ghcr.io/gitguardian/wolfi/valkey:latest --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - Existence of the claims in the transparency log was verified offline
Certificate issuer URL: https://token.actions.githubusercontent.com
GitHub Workflow Trigger: push
GitHub Workflow SHA: ced6b3cfab1341509de55bff7c0389ce81f73aae
GitHub Workflow Name: valkey
GitHub Workflow Repository: GitGuardian/wolfi
GitHub Workflow Ref: refs/heads/main
...
```

#### ✅ Download the Image SBOM Attestations

To download an attestation, use the `cosign` download attestation command and provide both the predicate type and the build platform. For example, the following command will obtain the SBOM for the valkey image on `linux/amd64`:

- **Production image**

```shell
cosign download attestation \
  --platform=linux/amd64 \
  --predicate-type=https://spdx.dev/Document \
  ghcr.io/gitguardian/wolfi/valkey:latest | jq -r .payload | base64 -d | jq .predicate
```

- **Shell image**
cosign download attestation \
  --platform=linux/amd64 \
  --predicate-type=https://spdx.dev/Document \
  ghcr.io/gitguardian/wolfi/valkey:latest-shell | jq -r .payload | base64 -d | jq .predicate
```
