Exec {
  path => ['/usr/bin', '/usr/local/bin'],
}

import 'nodejs_npm.pp'
import 'devtools.pp'
import 'startup.pp'

include nodejs_npm, devtools, startup
