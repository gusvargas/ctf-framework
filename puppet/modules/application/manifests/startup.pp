class application::startup {
  require application::devtools

  exec { 'start-server':
    command => 'supervisor -e coffee,hbs ./start.js 2> /home/vagrant/dev.log &',
    cwd => '/vagrant',
    creates => '/home/vagrant/dev.log'
  }
}

