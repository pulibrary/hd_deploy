class { 'ntp':
    servers => [ 'ntp1.corp.com', 'ntp2.corp.com' ],
  }

class { 'ruby':
  version         => '2.0.0',
  gems_version    => 'latest',
  rubygems_update => false
}
