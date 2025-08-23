# NixOS Installer

A minimalist NixOS installer configuration with LUKS2 encryption, Btrfs filesystem, and tmpfs root
for maximum security and performance.

## Features

- **LUKS2 Encryption**: Full disk encryption with FIDO2 support
- **Btrfs Subvolumes**: Organized filesystem with snapshots support
- **Tmpfs Root**: Stateless root filesystem for enhanced security
- **Impermanence**: Only essential data persists across reboots
- **Modern Hardware Support**: Intel CPU optimizations and NVMe support

## Disk Layout

The installer creates the following disk structure:

```
/dev/nvme0n1
├── ESP (512MB, vfat) → /boot
└── LUKS2 Encrypted Partition → Btrfs
    ├── / (tmpfs)
    ├── /btr_pool (top-level subvolume)
    ├── /nix (@nix subvolume)
    ├── /persist (@persist subvolume)
    ├── /var/log (@log subvolume)
    ├── /tmp (@tmp subvolume)
    ├── /.snapshots (@snapshots subvolume)
    └── /.swap (@swap subvolume, 32GB)
```

## Installation Steps

### 1. Boot NixOS Installer ISO

Download and boot from a NixOS installer ISO (minimal or graphical).

### 2. Connect to Internet

```bash
# For WiFi
sudo systemctl start wpa_supplicant
wpa_cli
> add_network
> set_network 0 ssid "YourWiFiName"
> set_network 0 psk "YourPassword"
> enable_network 0
> quit

# For Ethernet (usually automatic)
ip addr show
```

### 3. Clone Configuration

```bash
nix-shell -p git
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles/nixos-installer
```

### 4. Customize Disk Configuration (Optional)

Edit `hardware-configuration.nix` if you need to:

- Change disk device (default: `/dev/nvme0n1`)
- Adjust swap size (default: `32G`)
- Modify partition sizes

### 5. Partition and Format Disk

⚠️ **WARNING: This will DESTROY all data on the target disk!**

```bash
# Format disk with disko
sudo nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko --flake .#installer

# Alternative: Manual partitioning (advanced users)
# See "Manual Partitioning" section below
```

### 6. Install NixOS

```bash
# Install the system
sudo nixos-install --flake .#installer

# Set root password when prompted
# Or set it manually later:
sudo nixos-enter --root /mnt
passwd
exit
```

### 7. Reboot and Configure

```bash
sudo reboot
```

After reboot:

1. **Setup Persistent Data**: Move important configurations to `/persist`
2. **Configure Users**: Create your user account
3. **Install Main Configuration**: Deploy your full NixOS configuration
4. **Setup Secrets**: Configure SOPS or other secret management

## Post-Installation

### Setup FIDO2 (Optional)

If you have a FIDO2 security key:

```bash
# Enroll FIDO2 device for LUKS
sudo systemd-cryptenroll --fido2-device=auto /dev/nvme0n1p2
```

### Deploy Main Configuration

Replace the installer configuration with your main dotfiles:

```bash
# Clone your main configuration
cd /persist
git clone https://github.com/yourusername/dotfiles.git
cd dotfiles

# Build and switch to main configuration
sudo nixos-rebuild switch --flake .#yourhostname
```

## Manual Partitioning (Advanced)

If you prefer manual partitioning instead of disko:

### Create Partitions

```bash
# Create GPT partition table
sudo parted /dev/nvme0n1 -- mklabel gpt

# Create ESP (boot) partition
sudo parted /dev/nvme0n1 -- mkpart ESP fat32 1MiB 512MiB
sudo parted /dev/nvme0n1 -- set 1 esp on

# Create root partition
sudo parted /dev/nvme0n1 -- mkpart primary 512MiB 100%
```

### Setup LUKS Encryption

```bash
# Format LUKS2 partition
sudo cryptsetup luksFormat --type luks2 --cipher aes-xts-plain64 --hash sha512 --iter-time 5000 --key-size 256 --pbkdf argon2id --use-random /dev/nvme0n1p2

# Open encrypted partition
sudo cryptsetup luksOpen /dev/nvme0n1p2 crypted
```

### Create Btrfs Filesystem

```bash
# Create Btrfs filesystem
sudo mkfs.btrfs -L nixos /dev/mapper/crypted

# Mount and create subvolumes
sudo mount -t btrfs /dev/mapper/crypted /mnt
sudo btrfs subvolume create /mnt/@nix
sudo btrfs subvolume create /mnt/@persist
sudo btrfs subvolume create /mnt/@log
sudo btrfs subvolume create /mnt/@tmp
sudo btrfs subvolume create /mnt/@snapshots
sudo btrfs subvolume create /mnt/@swap
sudo umount /mnt

# Mount subvolumes
sudo mount -t tmpfs -o mode=755 none /mnt
sudo mkdir -p /mnt/{boot,nix,persist,var/log,tmp,.snapshots,.swap,btr_pool}

sudo mount /dev/nvme0n1p1 /mnt/boot
sudo mount -t btrfs -o subvol=@nix,compress=zstd,noatime,nodiratime,discard,nofail /dev/mapper/crypted /mnt/nix
sudo mount -t btrfs -o subvol=@persist,compress=zstd,noatime,nodiratime,discard,nofail /dev/mapper/crypted /mnt/persist
sudo mount -t btrfs -o subvol=@log,compress=zstd,noatime,nodiratime,discard,nofail /dev/mapper/crypted /mnt/var/log
sudo mount -t btrfs -o subvol=@tmp,noatime /dev/mapper/crypted /mnt/tmp
sudo mount -t btrfs -o subvol=@snapshots,compress=zstd,noatime,nodiratime,discard,nofail /dev/mapper/crypted /mnt/.snapshots
sudo mount -t btrfs -o subvol=@swap,noatime /dev/mapper/crypted /mnt/.swap
sudo mount -t btrfs -o subvolid=5 /dev/mapper/crypted /mnt/btr_pool

# Create swap file
sudo btrfs filesystem mkswapfile --size 32G /mnt/.swap/swapfile
sudo swapon /mnt/.swap/swapfile
```

## Troubleshooting

### Boot Issues

- Ensure UEFI boot mode is enabled
- Check that ESP partition is properly formatted and mounted
- Verify LUKS passphrase and/or FIDO2 device

### Disk Space Issues

- Adjust subvolume mount options in `hardware-configuration.nix`
- Modify swap size or disable swap entirely
- Use `btrfs filesystem show` to check space usage

### Hardware Detection Issues

- Update `hardware-configuration.nix` kernel modules
- Check `lspci` and `lsusb` for hardware identification
- Enable additional firmware in configuration

## Security Considerations

🔐 **Important Security Notes:**

- Root filesystem is mounted as tmpfs (ephemeral)
- Only `/persist` and `/nix` survive reboots
- LUKS2 encryption protects data at rest
- Consider enabling secure boot
- Use strong passphrases and/or FIDO2 keys
- Regular backups of `/persist` are essential

## References

- [NixOS Manual - Installation](https://nixos.org/manual/nixos/stable/index.html#sec-installation)
- [disko Documentation](https://github.com/nix-community/disko)
- [Impermanence Guide](https://github.com/nix-community/impermanence)
- [Btrfs Documentation](https://btrfs.wiki.kernel.org/)
