class devtools {
  require nodejs_npm

  exec { 'install-brunch':
    command => 'sudo npm install -g brunch',
  }

  exec { 'install-nodemon':
    command => 'sudo npm install -g nodemon',
  }
}

