---
name: wolfi-base-image
description: Scaffolds a new Wolfi base image in the GitGuardian/wolfi repository. Use when creating a new container image, adding an image to wolfi, or when user says "new image" or "add image".
---

# Wolfi Base Image Scaffolding

Creates all files for a new Wolfi-based container image following GitGuardian conventions.

## Inputs to Gather

Before generating files, confirm these with the user:

1. **Image name** (lowercase, e.g. `bun`, `nginx`, `helm`)
2. **Main package(s)** in Wolfi (e.g. `bun`, `nodejs`, `python-3.13`)
3. **Entrypoint** command (e.g. `/usr/bin/bun`, `/usr/bin/node`)
4. **Versions** to support (e.g. `["1.3"]`, `["3.13", "3.12"]`, or none)
5. **Variants** needed: `prod` (always), `shell` (optional), `dev` (optional, requires shell)
6. **Description** for OCI annotations (e.g. "Minimal Bun runtime image based on Wolfi")
7. **Extra packages** for shell or dev variants (beyond the standard set)
8. **CMD** (optional, e.g. `--help`, `--version`)

## File Generation

Generate files in this order. See [reference.md](reference.md) for full templates.

### 1. Root-Level Image Configs

**Always create `images/<name>/prod.yaml`:**

```yaml
include: images/apko.yaml

contents:
  packages:
    - ca-certificates-bundle
    - glibc-locale-posix
    - <MAIN_PACKAGE>
    - wolfi-baselayout

entrypoint:
  command: <ENTRYPOINT>

cmd: <CMD>  # omit if not needed

annotations:
  org.opencontainers.image.title: '<name>'
  org.opencontainers.image.description: '<DESCRIPTION>'
  org.opencontainers.image.source: 'https://github.com/GitGuardian/wolfi/tree/main/images/<name>'
```

**If shell variant, create `images/<name>/shell.yaml`:**

```yaml
include: images/<name>/prod.yaml

contents:
  packages:
    - bash
    - busybox
    - curl
    - openssl
    - wget
```

**If dev variant, create `images/<name>/dev.yaml`:**

```yaml
include: images/<name>/shell.yaml

contents:
  packages:
    - apk-tools
    - build-base
    - gettext
    - git
    - vim
    - wolfi-keys

accounts:
  run-as: root
```

### 2. Version Subdirectories

For each version (e.g. `1.3`), create `images/<name>/<version>/` with the selected variants.

**Versioned `prod.yaml`** pins the package:

```yaml
include: images/<name>/prod.yaml

contents:
  packages:
    - <MAIN_PACKAGE>~<VERSION>
```

**Versioned `shell.yaml` and `dev.yaml`** just re-include the parent:

```yaml
include: images/<name>/shell.yaml
```

**`latest/` directory** files are simple re-includes with no version pin:

```yaml
include: images/<name>/prod.yaml
```

### 3. CI Workflow

Create `.github/workflows/<name>.yaml`. The matrix strategy depends on variants and versions.

**Key rules:**
- Schedule: `"00 01 * * 1-5"` (weekdays at 01:00)
- Path triggers: `.github/workflows/<name>.yaml` and `images/<name>/**/*.yaml`
- Permissions: `contents: read`, `packages: write`, `attestations: write`, `id-token: write`, `security-events: write`, `actions: read`
- Tag format: `{version}` for prod, `{version}-shell` for shell, `{version}-dev` for dev
- Target format: `{version}/{variant}` when versions exist, `{variant}` when no versions

See [reference.md](reference.md) for the full workflow template.

### 4. README

Create `images/<name>/README.md` with:
- Title and one-line description
- Versions table (all version/variant combinations)
- Provenance verification (`gh attestation verify`)
- Cosign signature verification
- SBOM attestation verification and download

See [reference.md](reference.md) for the full README template.

### 5. Root README Update

Add a row to the `Available Images` table in `README.md`, in **alphabetical order**:

```
| [<name>](./images/<name>/) | `docker pull ghcr.io/gitguardian/wolfi/<name>` |
```

## Checklist

- [ ] `images/<name>/prod.yaml` with correct packages and annotations
- [ ] `images/<name>/shell.yaml` (if shell variant)
- [ ] `images/<name>/dev.yaml` (if dev variant)
- [ ] Version subdirectories with pinned packages
- [ ] `latest/` subdirectory with simple re-includes
- [ ] `.github/workflows/<name>.yaml` with correct matrix
- [ ] `images/<name>/README.md` with all verification sections
- [ ] Root `README.md` updated with new entry in alphabetical order
