_ = require 'underscore'
bcrypt = require 'bcrypt'

validateObj = (obj, attrs, strict=false) ->
  obj = _.pick obj, attrs

  if strict
    unless _.keys(obj).length is attrs.length
      return false

  obj

exports.validateChallenge = (challenge, strict=false) ->
  attrs = ['name', 'category', 'points', 'target', 'description', 'flag', 'locked']

  validateObj challenge, attrs, strict

exports.validateTeam = (team, strict=false) ->
  attrs = ['name', 'email', 'password']

  validateObj team, attrs, strict

exports.bcryptAttribute = (obj, key, callback) ->
  if key not of obj
    callback false, obj
    return

  value = obj[key]

  bcrypt.genSalt (err, salt) ->
    if err
      callback true

    bcrypt.hash value, salt, (err, hash) ->
      if err
        callback true

      obj[key] = hash
      callback false, obj
