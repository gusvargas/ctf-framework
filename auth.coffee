db = require './database'
utils = require './utils'
passport = require 'passport'
LocalStrategy = require('passport-local').Strategy
bcrypt = require 'bcrypt'

_ = require 'underscore'

passport.use new LocalStrategy
  usernameField: 'team'
  passwordField: 'password'
  , (team, password, done) ->
    db.getTeamByName team, (err, results) ->
      return done(err) if err

      unless results.length
        return done null, false,
          message: 'Invalid credentials'

      team = _.first results
      bcrypt.compare password, team.password, (err, res) ->
        if res
          done null, team
          return

        return done null, false,
          message: 'Invalid credentials'

passport.serializeUser (user, done) ->
  done null, user

passport.deserializeUser (user, done) ->
  done null, user

exports.passport = passport

exports.login = passport.authenticate 'local',
  successRedirect: '/'
  failureRedirect: '/login'
  failureFlash: true

exports.logout = (req, res) ->
  req.logout()
  res.redirect '/login'

exports.required = (req, res, next) ->
  return next() if req.isAuthenticated()
  res.redirect '/login'

exports.needsAdmin = (req, res, next) ->
  return next() if req.user?.admin
  res.send 403
