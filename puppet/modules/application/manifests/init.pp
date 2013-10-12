Exec {
  path => ['/usr/bin', '/usr/local/bin'],
}

class application {
  include application::nodejs_npm
  include application::devtools
  include application::startup
}
