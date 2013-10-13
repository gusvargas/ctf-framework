class application::startup {
  require application::devtools

  exec { 'start-server':
    command => 'nodemon -L start.js > /home/vagrant/dev.log &',
    cwd => '/vagrant',
    creates => '/home/vagrant/dev.log'
  }
}

