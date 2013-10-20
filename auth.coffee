db = require './database'
passport = require 'passport'
LocalStrategy = require('passport-local').Strategy

_ = require 'underscore'

passport.use new LocalStrategy
  usernameField: 'team'
  passwordField: 'password'
  , (team, password, done) ->
    db.checkCredentials team, password, (err, results) ->
      return done(err) if err

      unless results.length
        return done null, false,
          message: 'Invalid credentials'

      done null, _.first results

passport.serializeUser (user, done) ->
  done null, user.id

passport.deserializeUser (id, done) ->
  db.getUserById id, (err, response) ->
    done null, _.first response

exports.passport = passport

exports.process = passport.authenticate 'local',
  successRedirect: '/'
  failureRedirect: '/login'
  failureFlash: true

exports.required = (req, res, next) ->
  return next() if req.isAuthenticated()
  res.redirect '/login'
