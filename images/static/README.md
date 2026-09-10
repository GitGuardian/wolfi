# static

Minimal Wolfi-based image for running statically-linked binaries (Go, Rust, C/C++).

It ships only CA certificates, timezone data and a base layout with a non-root user (`nonroot`, uid/gid `65532`). There is no shell and no package manager, which keeps the attack surface minimal — a drop-in, distroless-style base for a compiled binary. Use it as the final stage of a multi-stage build and copy your statically-linked binary in.

## 🚀 Usage

```dockerfile
# build stage
FROM golang:1.24 AS build
WORKDIR /src
COPY . .
RUN CGO_ENABLED=0 go build -trimpath -ldflags="-s -w" -o /app ./cmd/app

# runtime stage — nothing but the binary, certs and tzdata
FROM ghcr.io/gitguardian/wolfi/static:latest
COPY --from=build /app /app
ENTRYPOINT ["/app"]
```

The image already runs as the non-root `nonroot` user, so no `USER` directive is required.

## Versions

| 📌 Version | ⬇️ Pull URL                              |
| --------- | --------------------------------------- |
| latest    | ghcr.io/gitguardian/wolfi/static:latest |

## ✅ Verify the Provenance

GitHub CLI ([gh](https://cli.github.com/)) can be used to retrieve the build provenance, which details the exact commit, workflow, and runner that produced the image:

- **Production image**

```shell
gh attestation verify \
  --owner gitguardian \
  oci://ghcr.io/gitguardian/wolfi/static:latest
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
  ghcr.io/gitguardian/wolfi/static:latest | jq
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
  ghcr.io/gitguardian/wolfi/static:latest
```

This will pull in the signature for the attestation specified by the --type parameter, which in this case is the SPDX attestation. You will receive output that verifies the SBOM attestation signature in cosign's transparency log:

```shell
Verification for ghcr.io/gitguardian/wolfi/static:latest --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - Existence of the claims in the transparency log was verified offline
  - The code-signing certificate was verified using trusted certificate authority certificates
Certificate subject: https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main
Certificate issuer URL: https://token.actions.githubusercontent.com
GitHub Workflow Trigger: push
GitHub Workflow SHA: ...
GitHub Workflow Name: static
GitHub Workflow Repository: GitGuardian/wolfi
GitHub Workflow Ref: refs/heads/main
...
```

#### ✅ Download the Image SBOM Attestations

To download an attestation, use the `cosign` download attestation command and provide both the predicate type and the build platform. For example, the following command will obtain the SBOM for the static image on `linux/amd64`:

- **Production image**

```shell
cosign download attestation \
  --platform=linux/amd64 \
  --predicate-type=https://spdx.dev/Document \
  ghcr.io/gitguardian/wolfi/static:latest | jq -r .payload | base64 -d | jq .predicate
```
