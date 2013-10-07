var sys = require('util');
var spawn = require('child_process').spawn;

var adminBrunch = spawn('/usr/bin/brunch', ['w'], {
  cwd: './static/adminUI/'
});

adminBrunch.stdout.on('data', function(data) {
  sys.print(data);
});

adminBrunch.stderr.on('data', function(data) {
  sys.print(data);
});
