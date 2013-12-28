module.exports = ->
  require('./main').apply null, arguments
  require('./api').apply null, arguments
