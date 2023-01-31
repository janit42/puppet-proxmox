# @summary This class removes the mainline linux kernel as soon as a proxmox pve kernel is running
class proxmox::cleanup {
  $kernels = $facts['os']['release']['major'] ? {
    '10'    => 'linux-image-4.19*',
    '11'    => 'linux-image-5.10*',
    default => '',
  }
  if  /-pve$/ in $facts['kernelrelease'] {
    package { ['linux-image-amd64', $kernels, 'os-prober']:
      ensure => 'absent',
    }
    ~>exec { '/usr/sbin/update-grub':
      refreshonly => true,
    }
  }
}
