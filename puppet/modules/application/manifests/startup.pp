class application::startup {
  require application::devtools

  exec { 'start-server':
    command => 'nodemon -L start.js &',
    cwd => '/vagrant',
  }
}

