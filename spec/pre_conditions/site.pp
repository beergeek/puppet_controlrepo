# We are not going to actually have this service anywhere on our servers but
# our code needs to refresh it. This is to trck puppet into doing nothing

# $servername = 'somemaster.puppetlabs.com' # Workaround for the lack of a master
$choco_install_path = 'C:\\foo'
$chocolateyversion = '0.10.10'
unless $concat_basedir {
  $concat_basedir = '/opt/puppetlabs/puppet/share/concat' # Workaround for lack of concat facts
}
service { 'pe-puppetserver':
  ensure     => 'running',
  enable     => false,
  hasrestart => false, # Force Puppet to use start and stop to restart
  start      => 'echo "Start"', # This will always work
  stop       => 'echo "Stop"', # This will also always work
  hasstatus  => false, # Force puppet to use our command for status
  status     => 'echo "Status"', # This will always exit 0 and therefor Puppet will think the service is running
  provider   => 'base',
}

user { 'puppet':
  ensure => present,
}

group { 'puppet':
  ensure => present,
}

class pe_repo::platform::windows_i386 {}
class pe_repo::platform::windows_x86_64 {}
class pe_repo::platform::el_6_x86_64 {}
