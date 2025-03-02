# Security Policy

This document outlines the security policies, including how to report vulnerabilities, verify artifact integrity, and understand the security measures in place.

## 📢 Reporting a Vulnerability

We take security seriously. If you discover a vulnerability in **ggbridge**, please report it using our confidentially our [Vulnerability Disclosure Portal](https://vdp.gitguardian.com).

Please avoid reporting security issues in public GitHub issues or discussions.

---

## 🔑 Provenance and Supply Chain Security

To ensure the integrity of our software, we provide a verifiable provenance for our **Docker images**.
You can find all provenance attestations [here](https://github.com/GitGuardian/ggbridge/attestations).

### 🏗️ **Build Provenance**

Our **wolfi-based** container images are built using **GitHub Actions** and follow best practices for **supply chain security** with a declarative approach leveraging **[apko](https://github.com/chainguard-dev/apko)**.

- **Base Image**: [`wolfi-base`](https://github.com/wolfi-dev/os)
- **Build System**: GitHub Actions (workflow: [`release.yml`](./.github/workflows/release.yml))
- **Declarative Build Spec**: [`apko.yaml`](./apko/prod.yaml) defines the image composition

#### ✅ Verify the Provenance

GitHub CLI ([gh](https://cli.github.com/)) can be used to retrieve the build provenance, which details the exact commit, workflow, and runner that produced the image:

- **Production image**

```shell
gh attestation verify \
  --owner gitguardian \
  oci://ghcr.io/gitguardian/wolfi/python:latest
```

- **Shell image**

```shell
gh attestation verify \
  --owner gitguardian \
  oci://ghcr.io/gitguardian/wolfi/python:latest-shell
```

### 📦 **Container Image Verification**

All official images are **cryptographically signed** using [Sigstore Cosign](https://www.sigstore.dev/).

#### ✅ Verify the Image Signature

To ensure the image is authentic and has not been tampered with, use the following command:

- **Production image**

```shell
cosign verify \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/python:latest | jq
```

- **Shell image**

```shell
cosign verify \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/python:latest-shell | jq
```

### 📦 **Container Image SBOMs**

To enhance transparency, we generate SBOMs for each release. SBOMs are available directly from the container registry
and can be verified using using [Sigstore Cosign](https://www.sigstore.dev/).

#### ✅ Verify the Image Attestations

- **Production image**

```shell
cosign verify-attestation \
  --type=https://spdx.dev/Document \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/python:latest
```

- **Shell image**

```shell
cosign verify-attestation \
  --type=https://spdx.dev/Document \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/python:latest-shell
```

This will pull in the signature for the attestation specified by the --type parameter, which in this case is the SPDX attestation. You will receive output that verifies the SBOM attestation signature in cosign's transparency log:

```shell
Verification for ghcr.io/gitguardian/wolfi/python:latest --
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
  ghcr.io/gitguardian/wolfi/python:latest | jq -r .payload | base64 -d | jq .predicate
```

- **Shell image**

```shell
cosign download attestation \
  --platform=linux/amd64 \
  --predicate-type=https://spdx.dev/Document \
  ghcr.io/gitguardian/wolfi/python:latest-shell | jq -r .payload | base64 -d | jq .predicate
```
