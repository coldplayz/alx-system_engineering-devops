# Ensures flask v2.1.0 os installed with pip3.

package { 'pip3':
  ensure  => installed,
}

package { 'flask':
  ensure   => '2.1.0',
  provider => pip3,
  require  => Package['pip3'],
}
