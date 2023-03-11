# Fix Nginx "accept4() failed (24: Too many open files)" message when simulating user requests

exec {'modify max open files limit setting':
  command => 'sed -i "s/holberton hard nofile [0-9]*/holberton hard nofile 4096/" /etc/security/limits.conf && sed -i "s/holberton soft nofile [0-9]*/holberton soft nofile 4096/" /etc/security/limits.conf',
  path    => '/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games',
}
