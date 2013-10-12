class application::startup {
  require application::devtools

  exec { 'start-server':
    command => 'nodemon start.js &',
    cwd => '/vagrant',
  }
}

