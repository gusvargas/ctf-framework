application = require 'application'

$ ->
  application.initialize()

  $.ajaxSetup
    headers:
      'X-CSRF-Token': $.cookie 'csrftoken'
