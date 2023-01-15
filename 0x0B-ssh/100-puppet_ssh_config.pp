# Sets configuration with Puppet.
# Ensures IdentityFile and PasswordAuthentication lines in ssh config

# Create config file if not exixts
exec { 'createFile':
  command => 'echo "Host *\n    IdentityFile ~/.ssh/id_rsa\n    PasswordAuthentication no" > /etc/ssh/ssh_config',
  creates => '/etc/ssh/ssh_config',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin',
}

# Ensure presence of generic Host configuration block
exec { 'checkHost':
  command => 'echo "Host *\n    IdentityFile ~/.ssh/id_rsa\n    PasswordAuthentication no" >> /etc/ssh/ssh_config',
  unless  => 'grep -x "Host \*" /etc/ssh/ssh_config',
  require => Exec['createFile'],
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin',
}

# Ensure presence of desired IdentityFile attribute
exec { 'idFile':
  command => 'sed -i "/Host \*/a\    IdentityFile ~\/.ssh\/id_rsa" /etc/ssh/ssh_config',
  unless  => 'grep -x "    IdentityFile .*ssh.*id_rsa" /etc/ssh/ssh_config',
  require => Exec['checkHost'],
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin',
}

# Ensure presence of desired PasswordAuthentication attribute
exec { 'noPasswd':
  command => 'sed -i "/Host \*/a\    PasswordAuthentication no" /etc/ssh/ssh_config',
  unless  => 'grep -x "    PasswordAuthentication no" /etc/ssh/ssh_config',
  require => Exec['idFile'],
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin',
}
