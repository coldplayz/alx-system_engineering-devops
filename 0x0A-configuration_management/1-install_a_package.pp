# Ensures flask v2.1.0 os installed with pip3.

package { 'pip':
  ensure  => installed,
}

package { 'flask':
  ensure   => '2.1.0',
  provider => pip,
  require  => Package['pip'],
}
