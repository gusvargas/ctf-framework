Exec {
  path => ['/usr/bin', '/usr/local/bin'],
}

class nodejs-npm {
  exec { "initial-update":
    command => 'sudo apt-get update',
  }

  package { 'python-software-properties':
    ensure => 'installed',
    require => Exec['initial-update'],
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

class devtools {
  require nodejs-npm

  exec { 'install-brunch':
    command => 'sudo npm install -g brunch',
  }

  exec { 'install-nodemon':
    command => 'sudo npm install -g nodemon',
  }
}

class startup {
  require devtools

  exec { 'start-server':
    command => 'nodemon start.js &',
    cwd => '/vagrant',
  }
}

include nodejs-npm, devtools, startup
