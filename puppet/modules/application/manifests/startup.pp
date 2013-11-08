class application::startup {
  require application::devtools

  exec { 'build-adminUI':
    command => 'brunch build',
    cwd => '/vagrant/static/adminUI',
  }

  exec { 'start-server':
    command => 'supervisor -e coffee,hbs ./start.js 2> /home/vagrant/dev.log &',
    cwd => '/vagrant',
    creates => '/home/vagrant/dev.log',
    require => Exec['build-adminUI'],
  }
}

