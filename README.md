# BlueBuild Silverblue Images

This repository contains custom base images built with the BlueBuild CLI. Forked from the official [BlueBuild Base Images](https://github.com/blue-build/base-images), this repository exclusively builds the latest Fedora Silverblue images with closed-sourced NVIDIA drivers. 

These images come with virtualization and undervolting support, along with other goodies modeled after the [Ublue Main Images](https://github.com/ublue-os/main).

## Images

| Recipe | Image | Version |
|---|---|---|
| recipe/fedora-silverblue-nvidia-latest.yml | ghcr.io/fermionbit/base-images/fedora-silverblue-nvidia | 44 (latest) |

## Installation

To rebase an existing atomic Fedora installation to the latest build (using the NVIDIA image as an example):

- First, rebase to the unsigned image to get the proper signing keys and policies installed:
  ```bash
  bootc switch ghcr.io/fermionbit/base-images/fedora-silverblue-nvidia:latest
  ```
- Reboot to complete the rebase:
  ```bash
  systemctl reboot
  ```
- Then, rebase to the signed image, like so:
  ```bash
  bootc switch --enforce-container-sigpolicy ghcr.io/fermionbit/base-images/fedora-silverblue-nvidia:latest
  ```
- Reboot again to complete the installation:
  ```bash
  systemctl reboot
  ```

## Verification

These images are signed with [Sigstore](https://www.sigstore.dev/)'s [cosign](https://github.com/sigstore/cosign). You can verify the signature by downloading the `cosign.pub` file from this repo and running the following command:

```bash
cosign verify --key cosign.pub ghcr.io/fermionbit/base-images/fedora-silverblue-nvidia:latest
```

## Secure Boot & MOK Keys

Because this repository signs the kernel and kernel modules (like NVIDIA drivers) with a custom key, moving to these images requires trusting this repository's specific key on your machine. 

You can easily pull the public `.der` key and use `mokutil` to trust it by running the following:

```bash
key=$(mktemp) && curl -fsSL "https://github.com/fermionbit/bluebuild-base/raw/refs/heads/main/files/base/etc/pki/akmods/certs/akmods-blue-build.der" -o "$key"
```

Then input your own password that you will use for verifying:

```bash
sudo mokutil --import "$key"
```

Finally you can reboot, enroll the key via the MOK manager before the OS starts up, and enter the password you provided during the `mokutil` import. This will allow your system to securely boot with the custom-compiled NVIDIA drivers without removing any other trusted keys you currently have.
