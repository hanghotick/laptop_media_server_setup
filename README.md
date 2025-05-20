# Headless Laptop Media Server Setup Script

A robust, interactive Bash script to turn a headless Ubuntu/Debian laptop into an efficient CasaOS-based media server. The script features a persistent menu, optional enhancements, and system health checks for a modern, user-friendly experience.

## Features

- **Menu-driven, interactive setup**
- **CasaOS install, user creation, and upgrade**
- **TLP power management**
- **Lid close behavior for headless operation**
- **CPU governor configuration**
- **Static IP and UFW firewall**
- **SSH server setup and hardening guidance**
- **Optional: Samba, USB automount, fail2ban**
- **System health check**
- **Clear guidance and robust error handling**

## Menu Structure

```
Main Menu
├── 1) Full Setup (CasaOS, TLP, Power, CPU, Network, Firewall, SSH, Monitoring)
├── 2) Install Samba (network file sharing)
├── 3) Enable automatic USB drive mounting
├── 4) Install fail2ban (SSH brute-force protection)
├── 5) System Health Check
├── 6) Print Guidance/Next Steps
├── 7) Upgrade CasaOS
└── 0) Exit
```

- After any action, you return to the main menu.
- All features are accessible at any time.

## System Requirements

- **Operating System:** Ubuntu/Debian (tested on 20.04+)
- **Privileges:** Must be run as root (use `sudo`)
- **Dependencies:**
  - curl, wget, apt, systemd, bash 4.0+
  - Docker (installed by CasaOS)
  - TLP, cpufrequtils, ufw (auto-installed)

## Installation & Usage

1. Clone the repository:
   ```pwsh
   git clone https://github.com/hanghotick/Server_script.git
   cd Server_script
   ```
2. Make the script executable:
   ```pwsh
   chmod +x laptop_media_server_setup.sh
   ```
3. Run the script as root:
   ```pwsh
   sudo bash laptop_media_server_setup.sh
   ```

## Menu Options Explained

- **Full Setup:** Installs CasaOS, creates user, sets up TLP, lid close, CPU governor, static IP, firewall, SSH, and monitoring tools.
- **Install Samba:** Adds network file sharing for `/media`.
- **Enable USB Automount:** Installs `usbmount` for automatic USB drive mounting.
- **Install fail2ban:** Adds brute-force protection for SSH.
- **System Health Check:** Shows disk, memory, CPU, network, and SMART status.
- **Print Guidance:** Shows next steps, tips, and CasaOS access info.
- **Upgrade CasaOS:** Upgrades CasaOS to the latest version using the official script.
- **Exit:** Exits the script.

## CasaOS App Installation

If any apps fail to auto-install, you can install them manually from the CasaOS App Store Web UI (http://<your-server-ip>:8181).

## Recommended Next Steps
- Set a static IP address for reliable access
- Mount external drives and configure storage
- Install monitoring tools (e.g., htop, vnstat)
- Harden SSH (disable password login, use SSH keys)
- Explore CasaOS App Store for more media apps (Jellyfin, Plex, Emby, etc.)

## License

This project is licensed under the GNU GPL v3. See the LICENSE file for details.

## Support

For issues and feature requests, please use the GitHub issue tracker.
