(function(ctf, $, undefined) {
  ctf.init({
    interval: 2000,
    callback: buildGameboard
  });

  var $tableHeader = $('table thead');
  var $tableBody = $('table tbody');

  function organizeChallenges(challenges) {
    var c = {};

    for (var i in challenges) {
      var challenge = challenges[i];
      var category = challenge.category;

      var thisCategory = c[category];
      if (!thisCategory) {
        c[category] = [];
        c[category].push(challenge);
      } else {
        for (var j in thisCategory) {
          var thisChallenge = thisCategory[j];

          if (challenge.points < thisChallenge.points) {
            thisCategory.splice(j, 0, challenge);
            break;
          }

          if (j == thisCategory.length - 1) {
            thisCategory.push(challenge);
          }
        }
      }
    }

    return c;
  }

  function drawTableHead(categories) {
    var $tr = $(document.createElement('tr'));

    for (var i in categories) {
      var $th = $(document.createElement('th'));

      $th.text(categories[i]);
      $tr.append($th);
    }

    $tableHeader.html($tr);
  }

  function mostChallengesInACategory(challenges) {
    var mostChallenges = 0;

    for (var key in challenges) {
      var thisLength = challenges[key].length;

      if (thisLength > mostChallenges) {
        mostChallenges = thisLength;
      }
    }

    return mostChallenges;
  }

  function drawTableBody(challenges) {
    $tableBody.empty();

    var mostChallenges = mostChallengesInACategory(challenges);

    for (var i = 0; i < mostChallenges; i++) {
      var $tr = $(document.createElement('tr'));

      for (var category in challenges) {
        var chals = challenges[category];
        var challenge = chals[i];
        var $td = $(document.createElement('td'));

        if (challenge) {
          $td.text(challenge.points);
        }

        $tr.append($td);
      }

      $tableBody.append($tr);
    }
  }

  function drawGameboard(challenges) {
    var categories = _.keys(challenges);

    drawTableHead(categories);
    drawTableBody(challenges);
  }

  function buildGameboard(challenges, scoreboard) {
    challenges = organizeChallenges(challenges);
    drawGameboard(challenges);
  }

  buildGameboard(window.challenges, window.scoreboard);

}(window.ctf, jQuery));
