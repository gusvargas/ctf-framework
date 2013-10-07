var sys = require('sys');
var spawn = require('child_process').spawn;

var adminBrunch = spawn('/usr/local/share/npm/bin/brunch', ['w'], {
  cwd: './adminUI/'
});

adminBrunch.stdout.on('data', function(data) {
  sys.print(data);
});

adminBrunch.stderr.on('data', function(data) {
  sys.print(data);
});
