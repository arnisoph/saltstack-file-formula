file:
  mounts:
    root:
      path: /
      device: /dev/mapper/vg0-root
      fstype: ext4
      pass_num: 1
      opts:
        - errors=remount-ro
        - grpjquota=aquota.group
        - jqfmt=vfsv0
    var_chroot:
      path: /var/chroot
      fstype: ext4
      pass_num: 2
      opts:
        - noatime
        - nodiratime
        - nodev
        - noexec
        - errors=remount-ro
        - grpjquota=aquota.group
        - jqfmt=vfsv0
  quota:
    root:
      path: /
      device: /dev/mapper/vg0-root
      type: group
    root_without_device:
      path: /var/chroot
      type: group
  symlinks:
    somedir:
      name: /path/where/symlink/should/be
      target: /target/path
