class application::nodejs_npm {
  package { 'python-software-properties':
    ensure => 'installed',
  }

  exec { 'add-apt-repo':
    command => 'add-apt-repository ppa:chris-lea/node.js',
    require => Package['python-software-properties'],
  }

  exec { 'apt-update':
    command => 'sudo apt-get update',
    require => Exec['add-apt-repo'],
  }

  exec { 'install-nodejs':
    command => 'sudo apt-get install -y --force-yes nodejs',
    require => Exec['apt-update'],
  }

  exec { 'install-server-deps':
    command => 'sudo npm install',
    cwd => '/vagrant',
    require => Exec['install-nodejs'],
  }

  exec { 'install-adminUI-deps':
    command => 'sudo npm install',
    cwd => '/vagrant/static/adminUI',
    require => Exec['install-nodejs'],
  }
}

