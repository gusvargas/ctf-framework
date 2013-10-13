class application::devtools {
  require application::nodejs_npm

  exec { 'install-brunch':
    command => 'sudo npm install -g brunch',
  }

  exec { 'install-supervisor':
    command => 'sudo npm install -g supervisor',
  }
}

