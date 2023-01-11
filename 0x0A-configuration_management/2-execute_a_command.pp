# Kills a process named `killmenow`

exec { 'killmenow':
  command => 'usr/bin/env pkill killmenow',
}
