(function(ctf, $, undefined) {
  'use strict';

  $.ajaxSetup({
    headers: {
      'X-CSRF-Token': $.cookie('csrftoken')
    }
  });

  var defaultOptions = {
    interval: 5000,
    callback: function() {}
  };

  ctf.init = function(options) {
    var opts = options || defaultOptions;
    var interval = parseInt(opts.interval, 10);

    if (isNaN(interval)) {
      throw new Error('Invalid refresh interval provided');
    }

    if (typeof opts.callback !== 'function') {
      throw new Error('Callback provided is not a function');
    }

    return setInterval(function() {
      ctf.fetchAll(opts.callback);
    }, interval);
  };

  ctf.fetchChallenges = function() {
    return $.ajax({
      url: '/api/challenges',
      dataType: 'json'
    });
  };

  ctf.fetchScoreboard = function() {
    return $.ajax({
      url: '/api/game/scoreboard',
      dataType: 'json'
    });
  };

  ctf.fetchAll = function(callback) {
    return Q.spread([ctf.fetchChallenges(), ctf.fetchScoreboard()], callback);
  };

}(window.ctf = window.ctf || {}, jQuery));

