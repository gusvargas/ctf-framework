bcrypt = require 'bcrypt'

exports.bcryptAttribute = (obj, key, callback) ->
  value = obj[key]

  bcrypt.genSalt (err, salt) ->
    if err
      callback true

    bcrypt.hash value, salt, (err, hash) ->
      if err
        callback true

      obj[key] = hash
      callback false, obj
