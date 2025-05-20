#!/bin/bash
# Ultimate Headless Laptop Media Server Setup Script
# For Ubuntu/Debian laptops (tested on 20.04+)
# Author: hanghotick (2025-05-20)
#
# This script installs CasaOS, configures power management for headless operation,
# sets up CPU scaling, firewall, SSH, and provides user guidance for a robust media server.
#
# Usage: sudo bash laptop_media_server_setup.sh

set -euo pipefail

# ====== Helper Functions ======
log() {
  local level="$1"; shift
  local msg="$*"
  local color
  case "$level" in
    INFO) color="\033[1;32m" ;;
    WARN) color="\033[1;33m" ;;
    ERROR) color="\033[1;31m" ;;
    *) color="\033[0m" ;;
  esac
  echo -e "${color}[$level] $msg\033[0m"
}

abort() {
  log ERROR "$1"
  exit 1
}

require_root() {
  if [[ $EUID -ne 0 ]]; then
    abort "This script must be run as root. Use: sudo bash $0"
  fi
}

# ====== 1. Install CasaOS ======
install_casaos() {
  log INFO "Installing CasaOS..."
  if command -v casaos &>/dev/null; then
    log INFO "CasaOS is already installed. Skipping."
  else
    curl -fsSL https://get.casaos.io | bash || abort "CasaOS installation failed."
    log INFO "CasaOS installed successfully."
  fi

  # Wait for CasaOS to be ready
  log INFO "Waiting for CasaOS to start..."
  sleep 10

  # Install ARR services, qBittorrent, Twingate, Tinfoil Store via CasaOS CLI
  if command -v casaos-cli &>/dev/null; then
    log INFO "Installing media apps via CasaOS CLI..."
    casaos-cli app install radarr || log WARN "Failed to auto-install Radarr. Install manually from CasaOS App Store."
    casaos-cli app install sonarr || log WARN "Failed to auto-install Sonarr. Install manually from CasaOS App Store."
    casaos-cli app install lidarr || log WARN "Failed to auto-install Lidarr. Install manually from CasaOS App Store."
    casaos-cli app install prowlarr || log WARN "Failed to auto-install Prowlarr. Install manually from CasaOS App Store."
    casaos-cli app install qbittorrent || log WARN "Failed to auto-install qBittorrent. Install manually from CasaOS App Store."
    casaos-cli app install twingate || log WARN "Failed to auto-install Twingate. Install manually from CasaOS App Store."
    casaos-cli app install tinfoil-store || log WARN "Failed to auto-install Tinfoil Store. Install manually from CasaOS App Store."
    true  # Ensure script continues even if any install fails
    log INFO "Requested installation of ARR, qBittorrent, Twingate, and Tinfoil Store."
  else
    log WARN "CasaOS CLI not found. Please install apps from the CasaOS App Store Web UI."
  fi
}

# ====== 2. Install TLP (Power Management) ======
install_tlp() {
  log INFO "Installing TLP (power management)..."
  if dpkg -l | grep -qw tlp; then
    log INFO "TLP is already installed. Skipping."
    return
  fi
  apt-get update && apt-get install -y tlp || abort "Failed to install TLP."
  systemctl enable tlp && systemctl start tlp
  log INFO "TLP installed and started."
}

# ====== 3. Configure Lid Close Behavior ======
configure_lid_behavior() {
  log INFO "Configuring lid close behavior for headless operation..."
  # Disable suspend/hibernate on lid close
  sed -i.bak -E \
    -e 's/^#?HandleLidSwitch=.*/HandleLidSwitch=ignore/' \
    -e 's/^#?HandleLidSwitchDocked=.*/HandleLidSwitchDocked=ignore/' \
    /etc/systemd/logind.conf
  # Apply changes
  systemctl restart systemd-logind.service
  log INFO "Lid close: system will NOT suspend/hibernate."
  # Turn off screen on lid close (optional, for laptops with working ACPI events)
  if grep -q 'event=button/lid' /etc/acpi/events/lid 2>/dev/null; then
    log INFO "ACPI lid event already configured."
  else
    mkdir -p /etc/acpi/events
    cat > /etc/acpi/events/lid <<EOF
# Turn off screen on lid close
event=button/lid.*
action=/usr/bin/xset dpms force off
EOF
    systemctl restart acpid || true
    log INFO "Configured ACPI event to turn off screen on lid close."
  fi
}

# ====== 4. CPU Governor Setup ======
install_cpufrequtils() {
  log INFO "Installing cpufrequtils (CPU scaling)..."
  if dpkg -l | grep -qw cpufrequtils; then
    log INFO "cpufrequtils already installed. Skipping."
    return
  fi
  apt-get install -y cpufrequtils || abort "Failed to install cpufrequtils."
}

configure_cpu_governor() {
  log INFO "Configuring CPU governor to 'ondemand'..."
  echo 'GOVERNOR=ondemand' > /etc/default/cpufrequtils
  systemctl restart cpufrequtils || service cpufrequtils restart || true
  # Apply immediately
  for cpu in /sys/devices/system/cpu/cpu[0-9]*; do
    echo ondemand > "$cpu/cpufreq/scaling_governor" 2>/dev/null || true
  done
  log INFO "CPU governor set to 'ondemand'."
}

# ====== 5. Network & Firewall ======
setup_ufw() {
  log INFO "Configuring UFW firewall..."
  apt-get install -y ufw
  ufw allow 22/tcp  # SSH
  ufw allow 80/tcp  # HTTP (CasaOS)
  ufw allow 443/tcp # HTTPS (CasaOS)
  ufw allow 8181/tcp # CasaOS WebUI (default)
  ufw --force enable
  log INFO "UFW enabled. Allowed: SSH, HTTP, HTTPS, CasaOS WebUI."
}

# ====== 6. User Guidance & Optional Enhancements ======
print_guidance() {
  echo -e "\n\033[1;36m==== SETUP COMPLETE ===="
  echo "\nAccess CasaOS Web UI: http://<your-server-ip>:8181"
  echo "\nThe following apps were requested for installation via CasaOS: Radarr, Sonarr, Lidarr, Prowlarr, qBittorrent, Twingate, Tinfoil Store."
  echo "If any failed to install automatically, you can install them from the CasaOS App Store."
  echo "\nRecommended next steps:"
  echo "- (Optional) Set a static IP address for reliable access."
  echo "  See: https://ubuntu.com/server/docs/network-configuration"
  echo "- (Optional) Mount external drives:"
  echo "  Use 'lsblk' to find devices, then edit /etc/fstab for persistent mounts."
  echo "- (Optional) Install smartmontools for disk health:"
  echo "    sudo apt-get install smartmontools"
  echo "- (Optional) Install monitoring tools:"
  echo "    sudo apt-get install htop vnstat"
  echo "- (Optional) Review CasaOS App Store for more media apps (Jellyfin, Plex, Emby, Transmission, etc.)"
  echo "- (Optional) Keep your system updated:"
  echo "    sudo apt-get update && sudo apt-get upgrade -y"
  echo "- (Optional) Harden SSH:"
  echo "    Edit /etc/ssh/sshd_config (e.g., set PasswordAuthentication no) and restart sshd."
  echo -e "\n\033[1;36m==== END OF INSTRUCTIONS ===="
}

# ====== Main Execution ======
main() {
  require_root
  log INFO "Starting headless laptop media server setup..."
  install_casaos
  install_tlp
  configure_lid_behavior
  install_cpufrequtils
  configure_cpu_governor
  setup_ufw
  setup_ssh
  print_guidance
  log INFO "Setup finished. Enjoy your headless media server!"
}

main "$@"
