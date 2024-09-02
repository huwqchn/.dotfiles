# Declarative Disk Management

## install
1. run: `curl https://raw.githubusercontent.com/<username>/<repo>/<branch>/path/to/disko-config.nix -o /tmp/disko.nix` for install the disko config file from github repository.

2. run: `nix --experimental-features "nix-command flakes" run github:nix-community/disko -- --mode disko /tmp/disko` for declare the disk partition and mounting

3. run: `mount | grep /mnt` for check the mount points

4. run: `nixos-generate-config --root /mnt --no-filesystems` to generate nixos configuration files without filesystem configuration (disko.nix holds thhe filesystem). and run `mv /tmp/disko.nix /mnt/etc/nixos/`

5. edit /etc/nixos/configuration.nix:
```
imports =
 [ # Include the results of the hardware scan.
   ./hardware-configuration.nix
   "${builtins.fetchTarball "https://github.com/nix-community/disko/archive/master.tar.gz"}/module.nix"
   ./disk-config.nix
 ];
```

6. run `nixos-install --root /mnt --no-root-password`