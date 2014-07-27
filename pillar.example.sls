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
  quota:
    root:
      path: /
      device: /dev/mapper/vg0-root
      type: group
