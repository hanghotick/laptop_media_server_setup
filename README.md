<<<<<<< HEAD
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

## Logic Tree (Menu Structure)

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

## Installation & Usage
=======
# Media Server Setup Script v2.1.0

A robust Linux media server setup and management script that automates the deployment of popular media services using Docker.

## Features

- **Linux Distribution Support**
  - Debian/Ubuntu-based distributions
  - RHEL/CentOS-based distributions
  - Arch Linux-based distributions
  - Other systemd-based distributions

- **Core Services**
  - Jellyfin (Media Server)
    - Hardware transcoding detection
    - Automatic resource optimization
    - Advanced health monitoring
  - Sonarr (TV Shows)
  - Radarr (Movies)
  - Lidarr (Music)
  - Prowlarr (Indexer)
  - qBittorrent (Download Client)
    - Automatic port forwarding detection
    - UPnP/NAT-PMP support
    - Advanced queue management

- **Advanced Features**
  - Comprehensive error handling with stack traces
  - Modular architecture with dynamic loading
  - Automated backups with integrity checks
  - System monitoring with resource thresholds
  - Network management with UDP port support
  - Service health checks with auto-recovery
  - Remote access configuration
  - Laptop power management
  - Configuration version control
  - Automatic dependency resolution
  - Docker container orchestration
  - Resource usage optimization

- **Enhanced Validation System**
  - YAML syntax validation
  - Permission checks with recursive validation
  - Firewall and port validation (TCP/UDP)
  - System resource verification
  - Docker volume validation
  - Service dependency checks
  - Network interface validation
  - Template variable validation
  - Hardware capability detection
  - Container health validation

## Directory Structure

```
.
├── lib/
│   ├── core/           # Core functionality
│   │   ├── error.sh    # Error handling
│   │   ├── logging.sh  # Logging system
│   │   └── validation.sh # Validation system
│   ├── os/             # OS-specific functionality
│   ├── package-managers/# Package management
│   ├── service-managers/# Service management
│   ├── docker/         # Docker management
│   ├── config/         # Configuration management
│   └── backup/         # Backup management
├── scripts/            # Individual service scripts
├── templates/          # Configuration templates
├── tests/             # Test suites
├── docs/              # Documentation
├── wiki/              # Wiki pages
├── config/            # Configuration files
├── backups/           # Backup storage
├── logs/              # Log files
└── docker/            # Docker configurations
```

## System Requirements

- **Operating System**
  - Linux: Any modern distribution with systemd
  - Kernel: 4.0 or later

- **Dependencies**
  - Docker 20.10+
  - Docker Compose 2.0+
  - bash 4.0+
  - systemd
  - netstat
  - ping
  - curl
  - wget
  - jq
  - Python3 or yq (for YAML validation)
  - UPnP/NAT-PMP tools (optional)

- **Hardware**
  - CPU: 2+ cores recommended
  - RAM: 4GB minimum, 8GB+ recommended
  - Storage: 5GB minimum for base installation
  - Network: Stable internet connection
  - GPU: Optional for hardware transcoding
    - Intel QuickSync
    - NVIDIA (with drivers)
    - AMD (with drivers)

## Installation
>>>>>>> casaos-modernization

1. Clone the repository:
   ```bash
   git clone https://github.com/hanghotick/Server_script.git
   cd Server_script
   ```
<<<<<<< HEAD
2. Make the script executable:
   ```bash
   chmod +x laptop_media_server_setup.sh
   ```
3. Run the script as root:
   ```bash
   sudo bash laptop_media_server_setup.sh
   ```

## Menu Options Explained

- **Full Setup:** Installs CasaOS, creates user `peter`, sets up TLP, lid close, CPU governor, static IP, firewall, SSH, and monitoring tools.
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
=======

2. Make the script executable:
   ```bash
   chmod +x Media_server.sh
   ```

3. Run the script:
   ```bash
   ./Media_server.sh
   ```

## Usage

The script provides an interactive menu with the following options:

1. **Full Setup** - Installs and configures all services
2. **Configure Network** - Network setup and port configuration
3. **Setup Docker Services** - Individual service management
4. **Manage Backups** - Backup creation and restoration
5. **Monitor System** - System resource monitoring
6. **View Service Status** - Check running services
7. **View Logs** - Service log management

### Remote Access Options
8. **Configure SSH** - Set up remote access
9. **View SSH Status** - Check remote access status

### Laptop Management Options
10. **View Laptop Status** - System status overview
11. **Set Power Profile** - Power management settings
12. **Set Screen Brightness** - Display settings
13. **Start Laptop Monitoring** - Resource monitoring
14. **Set Lid Close Action** - Laptop behavior configuration

## Default Service Ports

- Jellyfin: 8096
- Sonarr: 8989
- Radarr: 7878
- Lidarr: 8686
- Prowlarr: 9696
- qBittorrent: 8080

## Error Handling and Validation

The script includes comprehensive error handling and validation:

- **Preflight Checks**
  - System resource verification
  - Dependency validation
  - Network connectivity (TCP/UDP)
  - Port availability
  - File permissions (recursive)
  - Docker status and version
  - Hardware capability detection
  - Container runtime verification

- **Configuration Validation**
  - YAML/JSON syntax checking
  - Required variable verification
  - Template validation
  - Service dependency validation
  - Version control and upgrades
  - Environment variable validation

- **Runtime Validation**
  - Docker volume mounts
  - Network interface status
  - Service health checks
  - Port accessibility (TCP/UDP)
  - Resource monitoring
  - Hardware transcoding support
  - Container health status
  - Resource usage thresholds

- **Error Management**
  - Standardized error codes
  - Stack traces for debugging
  - Detailed error messages
  - Automatic recovery attempts
  - Configuration backups
  - Rollback capabilities
  - Service state recovery

## Error Codes

The `install.sh` script now uses defined error codes for robust error handling:

- `E_SUCCESS=0` – Success
- `E_CONFIG=10` – Configuration error (e.g., missing required path variables)
- `E_PERMISSION=13` – Permission error (e.g., parent directory not writable)
- `E_FILESYSTEM=30` – Filesystem error (e.g., failed to create directory)

These codes are defined at the top of the script and used throughout for consistent returns and debugging.

## Directory Creation Logic

- Parent directory writability is only checked if the parent exists, preventing false errors if the parent will be created.
- All variable expansions in for loops and command substitutions are quoted to prevent globbing and word splitting.

## General Improvements

- The script is more robust and portable for different Linux environments.
- All return codes in `create_directories` are now defined and handled.

## Testing

The project includes a comprehensive test suite to ensure reliability and proper functionality. To run the tests:

```bash
# Run all tests
./tests/run_tests.sh

# Run a specific test suite
./tests/test_validation.sh
```

### Test Coverage

The test suite covers:
- System validation (resources, permissions)
- Network validation (connectivity, ports)
- Docker configuration validation
- YAML/JSON syntax validation
- Environment variable validation
- Error handling and recovery
- Service health checks

### Writing Tests

To add new tests:
1. Create a new test file in the `tests/` directory with the prefix `test_`
2. Source the required libraries
3. Use the provided test helper functions (`assert_success`, `assert_failure`)
4. Add test cases for both success and failure scenarios
5. Include cleanup code to remove test artifacts

Example test case:
```bash
test_my_feature() {
    echo "Testing my feature..."
    
    # Test success case
    my_feature_function "valid_input"
    assert_success "Valid input test" $?
    
    # Test failure case
    my_feature_function "invalid_input"
    assert_failure "Invalid input test" $? $E_VALIDATION
}
```

## Contributing

1. Fork the repository
2. Create a feature branch
3. Commit your changes
4. Push to the branch
5. Create a Pull Request
>>>>>>> casaos-modernization

## License

This project is licensed under the MIT License - see the LICENSE file for details.

## Support

For issues and feature requests, please use the GitHub issue tracker.
