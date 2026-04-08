# Wolfi Base Image Reference

Complete templates for all generated files. Substitute placeholders:
- `<NAME>` - image name (lowercase)
- `<MAIN_PACKAGE>` - Wolfi package name
- `<ENTRYPOINT>` - full path to entrypoint binary
- `<DESCRIPTION>` - OCI image description
- `<VERSION>` - version string (e.g. `1.3`, `3.13`)
- `<VERSIONS_JSON>` - JSON array for matrix (e.g. `[latest, "1.3"]`)
- `<VARIANTS_JSON>` - JSON array for matrix (e.g. `[prod, shell, dev]`)

## Table of Contents

1. [CI Workflow Template](#ci-workflow-template)
2. [README Template](#readme-template)
3. [Version Pinning Rules](#version-pinning-rules)
4. [Advanced Patterns](#advanced-patterns)

---

## CI Workflow Template

```yaml
name: <NAME>

on:
  schedule:
    - cron: "00 01 * * 1-5"
  pull_request:
    paths:
      - .github/workflows/<NAME>.yaml
      - 'images/<NAME>/*.yaml'
      - 'images/<NAME>/**/*.yaml'
  push:
    branches:
      - 'main'
    paths:
      - .github/workflows/<NAME>.yaml
      - 'images/<NAME>/*.yaml'
      - 'images/<NAME>/**/*.yaml'
  workflow_dispatch:

permissions:
  contents: read
  packages: write
  attestations: write
  id-token: write
  security-events: write
  actions: read

jobs:
  publish:
    strategy:
      matrix:
        version: <VERSIONS_JSON>
        variant: <VARIANTS_JSON>
    name: ${{ matrix.version }}${{ matrix.variant == 'shell' && '-shell' || matrix.variant == 'dev' && '-dev' || '' }}
    uses: './.github/workflows/release.yaml'
    with:
      tag: ${{ matrix.version }}${{ matrix.variant == 'shell' && '-shell' || matrix.variant == 'dev' && '-dev' || '' }}
      target: ${{ format('{0}/{1}', matrix.version, matrix.variant) }}
    secrets: inherit
```

**When no version subdirectories exist** (single-version image), use:

```yaml
jobs:
  publish:
    strategy:
      matrix:
        version: [latest]
        variant: <VARIANTS_JSON>
    name: ${{ matrix.version }}${{ matrix.variant == 'shell' && '-shell' || matrix.variant == 'dev' && '-dev' || '' }}
    uses: './.github/workflows/release.yaml'
    with:
      tag: ${{ matrix.version }}${{ matrix.variant == 'shell' && '-shell' || matrix.variant == 'dev' && '-dev' || '' }}
      target: ${{ matrix.variant }}
    secrets: inherit
```

Note: `target` uses `matrix.variant` directly (no version prefix) when there are no version subdirectories.

---

## README Template

```markdown
# <NAME>

<DESCRIPTION>

## Versions

| Version      | Pull URL                                         |
| ------------ | ------------------------------------------------ |
<!-- One row per version/variant combination, e.g.: -->
| latest       | ghcr.io/gitguardian/wolfi/<NAME>:latest          |
| latest-shell | ghcr.io/gitguardian/wolfi/<NAME>:latest-shell    |
| latest-dev   | ghcr.io/gitguardian/wolfi/<NAME>:latest-dev      |
| <VERSION>       | ghcr.io/gitguardian/wolfi/<NAME>:<VERSION>       |
| <VERSION>-shell | ghcr.io/gitguardian/wolfi/<NAME>:<VERSION>-shell |
| <VERSION>-dev   | ghcr.io/gitguardian/wolfi/<NAME>:<VERSION>-dev   |

## Verify the Provenance

GitHub CLI ([gh](https://cli.github.com/)) can be used to retrieve the build provenance, which details the exact commit, workflow, and runner that produced the image:

- **Production image**

\`\`\`shell
gh attestation verify \
  --owner gitguardian \
  oci://ghcr.io/gitguardian/wolfi/<NAME>:latest
\`\`\`

- **Shell image**

\`\`\`shell
gh attestation verify \
  --owner gitguardian \
  oci://ghcr.io/gitguardian/wolfi/<NAME>:latest-shell
\`\`\`

## Image Verification

All official images are **cryptographically signed** using [Sigstore Cosign](https://www.sigstore.dev/).

### Verify the Image Signature

To ensure the image is authentic and has not been tampered with, use the following command:

- **Production image**

\`\`\`shell
cosign verify \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/<NAME>:latest | jq
\`\`\`

- **Shell image**

\`\`\`shell
cosign verify \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/<NAME>:latest-shell | jq
\`\`\`

### Image SBOMs

To enhance transparency, we generate SBOMs for each release. SBOMs are available directly from the container registry
and can be verified using using [Sigstore Cosign](https://www.sigstore.dev/).

#### Verify the Image Attestations

- **Production image**

\`\`\`shell
cosign verify-attestation \
  --type=https://spdx.dev/Document \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/<NAME>:latest
\`\`\`

- **Shell image**

\`\`\`shell
cosign verify-attestation \
  --type=https://spdx.dev/Document \
  --certificate-oidc-issuer=https://token.actions.githubusercontent.com \
  --certificate-identity=https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main \
  ghcr.io/gitguardian/wolfi/<NAME>:latest-shell
\`\`\`

This will pull in the signature for the attestation specified by the --type parameter, which in this case is the SPDX attestation. You will receive output that verifies the SBOM attestation signature in cosign's transparency log:

\`\`\`shell
Verification for ghcr.io/gitguardian/wolfi/<NAME>:latest --
The following checks were performed on each of these signatures:
  - The cosign claims were validated
  - Existence of the claims in the transparency log was verified offline
  - The code-signing certificate was verified using trusted certificate authority certificates
Certificate subject: https://github.com/GitGuardian/wolfi/.github/workflows/release.yaml@refs/heads/main
Certificate issuer URL: https://token.actions.githubusercontent.com
GitHub Workflow Trigger: push
GitHub Workflow SHA: ...
GitHub Workflow Name: <NAME>
GitHub Workflow Repository: GitGuardian/wolfi
GitHub Workflow Ref: refs/heads/main
...
\`\`\`

#### Download the Image SBOM Attestations

To download an attestation, use the `cosign` download attestation command and provide both the predicate type and the build platform. For example, the following command will obtain the SBOM for the <NAME> image on `linux/amd64`:

- **Production image**

\`\`\`shell
cosign download attestation \
  --platform=linux/amd64 \
  --predicate-type=https://spdx.dev/Document \
  ghcr.io/gitguardian/wolfi/<NAME>:latest | jq -r .payload | base64 -d | jq .predicate
\`\`\`

- **Shell image**

\`\`\`shell
cosign download attestation \
  --platform=linux/amd64 \
  --predicate-type=https://spdx.dev/Document \
  ghcr.io/gitguardian/wolfi/<NAME>:latest-shell | jq -r .payload | base64 -d | jq .predicate
\`\`\`
```

---

## Version Pinning Rules

| Syntax | Meaning | Example |
| --- | --- | --- |
| `<pkg>` | Latest available | `bun` |
| `<pkg>~X.Y` | Compatible release >= X.Y, < (X+1).0 | `bun~1.3` |
| `<pkg>~X.Y.Z` | Exact patch pin >= X.Y.Z | `istio-envoy-1.25~1.25.2` |

Some packages use version-suffixed names: `python-3.13`, `nodejs-22`. Check Wolfi package registry if unsure.

---

## Advanced Patterns

### Custom User/Group

Override in `prod.yaml` when the runtime needs a named user:

```yaml
accounts:
  groups:
    - groupname: <username>
      gid: 65532
  users:
    - username: <username>
      uid: 65532
      gid: 65532
  run-as: <username>

work-dir: /home/<username>
```

### Custom Directories

When the runtime needs writable paths:

```yaml
paths:
  - path: /var/lib/<name>
    type: directory
    permissions: 0o755
    uid: 65532
    gid: 65532
```

### Dynamic Package Pinning via Workflow

For images where version directories don't exist but you still want version-pinned builds, use the `packages` workflow input:

```yaml
with:
  packages: >-
    ${{ matrix.version != 'latest' && format('<pkg>~{0}', matrix.version) || '' }}
```
