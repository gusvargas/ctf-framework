class application {
  Exec {
    path => ['/usr/bin', '/usr/local/bin'],
  }

  include application::nodejs_npm
  include application::devtools
  include application::startup
}
