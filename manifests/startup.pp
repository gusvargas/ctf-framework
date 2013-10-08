class startup {
  require devtools

  exec { 'start-server':
    command => 'nodemon start.js &',
    cwd => '/vagrant',
  }
}

