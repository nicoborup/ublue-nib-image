#!/bin/bash

set -ouex pipefail

### Install packages
mkdir -p /tmp/rpms

# Packages can be installed from any enabled yum repo on the image.
# RPMfusion repos are available by default in ublue main images
# List of rpmfusion packages can be found here:
# https://mirrors.rpmfusion.org/mirrorlist?path=free/fedora/updates/39/x86_64/repoview/index.html&protocol=https&redirect=1

# this installs a package from fedora repos
dnf5 install -y tmux

# Use a COPR Example:
#
# dnf5 -y copr enable ublue-os/staging
# dnf5 -y install package
# Disable COPRs so they don't end up enabled on the final image:
# dnf5 -y copr disable ublue-os/staging

#### Example for enabling a System Unit File

systemctl enable podman.socket

# Add keyd
dnf5 -y copr enable alternateved/keyd
dnf5 -y install keyd
# Disable COPRs so they don't end up enabled on the final image:
dnf5 -y copr disable alternateved/keyd

# Add NetworkManager-l2tp
dnf5 install -y NetworkManager-l2tp strongswan
#rpm -e --nodeps libreswan || echo ""

# Add tilix terminal emulator
dnf5 install -y tilix

# Add tilix terminal emulator
dnf5 install -y minicom

# Install Brother printer driver
curl --retry 3 -Lo /tmp/rpms/brother-printer-driver.rpm https://download.brother.com/welcome/dlf101090/mfcl8650cdwlpr-1.1.2-1.i386.rpm
rpm  -ihv  --nodeps  /tmp/rpms/brother-printer-driver.rpm
