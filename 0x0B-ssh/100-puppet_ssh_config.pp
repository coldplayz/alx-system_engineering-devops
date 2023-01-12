# Sets configuration with Puppet.

file_line { 'use_school':
  ensure => present,
  path   => '~/.ssh/config',
  line   => 'Host *\n  IdentityFile ~/.ssh/school\n',
}

file_line { 'no_passphrase':
  ensure  => present,
  path    => '~/.ssh/config',
  line    => '  PasswordAuthentication no\n',
  require => File_line['use_school'],
}
