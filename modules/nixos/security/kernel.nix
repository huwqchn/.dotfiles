{
  config,
  lib,
  ...
}: let
  inherit (lib.lists) optionals;
  inherit (lib.modules) mkForce mkIf;
  inherit (lib.options) mkEnableOption;

  cfg = config.my.security;
in {
  options.my.security = {
    fixWebcam = mkEnableOption "fix webcam";
    noMitigations = mkEnableOption "Disable all CPU mitigations";
  };
  config = mkIf cfg.enable {
    security = {
      protectKernelImage = true; # disables hibernation

      # Breaks virtd, wireguard, iptables and many more features by
      # disallowing them from loading modules during runtime. You may
      # enable this module if you wish, but do make sure that the
      # necessary modules are loaded declaratively before doing so.
      # Failing to add those modules may result in an unbootable system!
      lockKernelModules = false;

      # Force-enable the Page Table Isolation (PTI) Linux kernel feature
      # helps mitigate Meltdown and prevent some KASLR bypasses.
      forcePageTableIsolation = true;

      # User namespaces are required for sandboxing. Better than nothing imo.
      allowUserNamespaces = true;

      # Disable unprivileged user namespaces, unless containers are enabled
      # required by podman to run containers in rootless mode.
      unprivilegedUsernsClone = config.virtualisation.containers.enable;

      allowSimultaneousMultithreading = true;
    };

    boot = {
      kernel = {
        # https://docs.kernel.org/admin-guide/sysctl/vm.html
        sysctl = mkIf (config.my.machine.type != "wsl") {
          # The Magic SysRq key is a key combo that allows users connected to the
          # system console of a Linux kernel to perform some low-level commands.
          # Disable it, since we don't need it, and is a potential security concern.
          "kernel.sysrq" = mkForce 0;

          # Restrict ptrace() usage to processes with a pre-defined relationship
          # (e.g., parent/child)
          "kernel.yama.ptrace_scope" = 3;

          # Hide kptrs even for processes with CAP_SYSLOG
          # also prevents printing kernel pointers
          "kernel.kptr_restrict" = 2;

          # Disable bpf() JIT (to eliminate spray attacks)
          "net.core.bpf_jit_enable" = false;

          # Disable ftrace debugging
          "kernel.ftrace_enabled" = false;

          # Avoid kernel memory address exposures via dmesg (this value can also be set by CONFIG_SECURITY_DMESG_RESTRICT).
          "kernel.dmesg_restrict" = 1;

          # Prevent creating files in potentially attacker-controlled environments such
          # as world-writable directories to make data spoofing attacks more difficult
          "fs.protected_fifos" = 2;

          # Prevent unintended writes to already-created files
          "fs.protected_regular" = 2;

          # Disable SUID binary dump
          "fs.suid_dumpable" = 0;

          # Prevent unprivileged users from creating hard or symbolic links to files
          "fs.protected_symlinks" = 1;
          "fs.protected_hardlinks" = 1;

          # Disable late module loading
          # "kernel.modules_disabled" = 1;

          # Disallow profiling at all levels without CAP_SYS_ADMIN
          "kernel.perf_event_paranoid" = 3;

          # Require CAP_BPF to use bpf
          "kernel.unprivileged_bpf_disabled" = true;

          # Prevent boot console kernel log information leaks
          "kernel.printk" = "3 3 3 3";

          # Restrict loading TTY line disciplines to the CAP_SYS_MODULE capability to
          # prevent unprivileged attackers from loading vulnerable line disciplines with
          # the TIOCSETD ioctl
          "dev.tty.ldisc_autoload" = 0;

          # Kexec allows replacing the current running kernel. There may be an edge case where
          # you wish to boot into a different kernel, but I do not require kexec. Disabling it
          # patches a potential security hole in our system.
          "kernel.kexec_load_disabled" = true;

          # Borrowed by NixOS/nixpkgs. Since the security module does not explain what those
          # options do, it is up you to educate yourself dear reader.
          # See:
          #  - <https://docs.kernel.org/admin-guide/sysctl/vm.html#mmap-rnd-bits>
          #  - <https://docs.kernel.org/admin-guide/sysctl/vm.html#mmap-min-addr>
          # "vm.mmap_rnd_bits" = 32;
          # "vm.mmap_min_addr" = 65536;
        };
      };

      # https://www.kernel.org/doc/html/latest/admin-guide/kernel-parameters.html
      kernelParams =
        if cfg.noMitigations
        then [
          # disables the L1 Terminal Fault (L1TF) mitigation, which is a hardware mitigation
          # for L1TF (CVE-2018-3620 and CVE-2018-3646).
          "l1tf=off"

          # Disables the Microarchitectural Data Sampling (MDS) mitigation, which is
          # a hardware mitigation for MDS (CVE-2018-12126, CVE-2018-12127, CVE-2018-12130, CVE-2019-11091)
          "mds=off"

          # Disables the Single Thread Indirect Branch Predictors (STIBP) feature,
          # which is a hardware mitigation for Spectre variant 2
          "no_stf_barrier"

          # disables the Indirect Branch Predictor Barrier (IBPB) feature, which is a software
          # mitigation for Spectre variant 2
          "noibpb"

          # disables the Indirect Branch Restricted Speculation (IBRS) feature, which is
          # a hardware mitigation for Spectre variant 2 (CVE-2017-5715)
          "noibrs"

          # disables the Kernel Page Table Isolation (KPTI) feature, which is a software
          # mitigation for Meltdown (CVE-2017-5754)
          "nopti"

          # disables the Speculative Store Bypass Disable (SSBD) feature, which is a
          # hardware mitigation for Spectre variant 4 (CVE-2018-3639)
          "nospec_store_bypass_disable"

          # disables all mitigations for Spectre variant 1 (CVE-2017-5753)
          "nospectre_v1"

          # disables all mitigations for Spectre variant 2, including IBRS and IBPB.
          "nospectre_v2"

          # enables Intel Transactional Synchronization Extensions (TSX), which can
          # improve performance for certain workloads that use transactional memory
          "tsx=on"

          # disables the TSX Asynchronous Abort (TAA) mitigation, which is a hardware
          # mitigation for TAA (CVE-2019-11135)
          "tsx_async_abort=off"

          # Disable all mitigations
          "mitigations=off"
        ]
        else [
          # NixOS produces many wakeups per second, which is bad for battery life.
          # This kernel parameter disables the timer tick on the last 4 cores
          "nohz_full=4-7"

          # make stack-based attacks on the kernel harder
          "randomize_kstack_offset=on"

          # controls the behavior of vsyscalls. this has been defaulted to none back in 2016 - break really old binaries for security
          "vsyscall=none"

          # reduce most of the exposure of a heap attack to a single cache
          "slab_nomerge"

          # Disable debugfs which exposes sensitive kernel data
          "debugfs=off"

          # Sometimes certain kernel exploits will cause what is called an "oops" which is a kernel panic
          # that is recoverable. This will make it unrecoverable, and therefore safe to those attacks
          "oops=panic"

          # only allow signed modules
          "module.sig_enforce=1"

          # blocks access to all kernel memory, even preventing administrators from being able to inspect and probe the kernel
          "lockdown=confidentiality"

          # enable buddy allocator free poisoning
          "page_poison=on"

          # performance improvement for direct-mapped memory-side-cache utilization, reduces the predictability of page allocations
          "page_alloc.shuffle=1"

          # for debugging kernel-level slab issues
          "slub_debug=FZP"

          # disable sysrq keys. sysrq is seful for debugging, but also insecure
          "sysrq_always_enabled=0" # 0 | 1 # 0 means disabled

          # ignore access time (atime) updates on files, except when they coincide with updates to the ctime or mtime
          "rootflags=noatime"

          # linux security modules
          "lsm=landlock,lockdown,yama,integrity,apparmor,bpf,tomoyo,selinux"

          # prevent the kernel from blanking plymouth out of the fb
          "fbcon=nodefer"
        ];

      blacklistedKernelModules = lib.concatLists [
        # Obscure network protocols
        [
          "dccp" # Datagram Congestion Control Protocol
          "sctp" # Stream Control Transmission Protocol
          "rds" # Reliable Datagram Sockets
          "tipc" # Transparent Inter-Process Communication
          "n-hdlc" # High-level Data Link Control
          "netrom" # NetRom
          "x25" # X.25
          "ax25" # Amateur X.25
          "rose" # ROSE
          "decnet" # DECnet
          "econet" # Econet
          "af_802154" # IEEE 802.15.4
          "ipx" # Internetwork Packet Exchange
          "appletalk" # Appletalk
          "psnap" # SubnetworkAccess Protocol
          "p8022" # IEEE 802.3
          "p8023" # Novell raw IEEE 802.3
          "can" # Controller Area Network
          "atm" # ATM
        ]

        # Old or rare or insufficiently audited filesystems
        [
          "adfs" # Active Directory Federation Services
          "affs" # Amiga Fast File System
          "befs" # "Be File System"
          "bfs" # BFS, used by SCO UnixWare OS for the /stand slice
          "cifs" # Common Internet File System
          "cramfs" # compressed ROM/RAM file system
          "efs" # Extent File System
          "erofs" # Enhanced Read-Only File System
          "exofs" # EXtended Object File System
          "freevxfs" # Veritas filesystem driver
          "f2fs" # Flash-Friendly File System
          "vivid" # Virtual Video Test Driver (unnecessary, and a historical cause of escalation issues)
          "gfs2" # Global File System 2
          "hpfs" # High Performance File System (used by OS/2)
          "hfs" # Hierarchical File System (Macintosh)
          "hfsplus" # " same as above, but with extended attributes
          "jffs2" # Journalling Flash File System (v2)
          "jfs" # Journaled File System - only useful for VMWare sessions
          "ksmbd" # SMB3 Kernel Server
          "minix" # minix fs - used by the minix OS
          "nfsv3" # " (v3)
          "nfsv4" # Network File System (v4)
          "nfs" # Network File System
          "nilfs2" # New Implementation of a Log-structured File System
          "omfs" # Optimized MPEG Filesystem
          "qnx4" # extent-based file system used by the QNX4 and QNX6 OSes
          "qnx6" # "
          "squashfs" # compressed read-only file system (used by live CDs)
          "sysv" # implements all of Xenix FS, SystemV/386 FS and Coherent FS.
          "udf" # https://docs.kernel.org/5.15/filesystems/udf.html
        ]

        # Disable Thunderbolt and FireWire to prevent DMA attacks
        [
          "thunderbolt"
          "firewire-core"
        ]

        # You might possibly want your webcam to work.
        # We whitelist the module if the system wants
        # webcam to work
        (optionals (!cfg.fixWebcam) [
          "uvcvideo" # this is why your webcam no worky
        ])

        # if bluetooth is enabled, whitelist the module
        # necessary for bluetooth dongles to work
        (optionals (!config.my.machine.hasBluetooth) [
          "bluetooth" # let bluetooth work
          "btusb" # let bluetooth dongles work
        ])
      ];
    };
  };
}
