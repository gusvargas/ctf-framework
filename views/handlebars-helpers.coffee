_ = require 'underscore'

helpers =
  stringify: (data, isChallenges=false) ->
    if isChallenges and data instanceof Array
      data = data.map (challenge) ->
        _.omit challenge, ['flag', 'locked']

    JSON.stringify data

module.exports = helpers
