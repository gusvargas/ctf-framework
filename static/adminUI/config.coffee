exports.config =
  # See docs at http://brunch.readthedocs.org/en/latest/config.html.
  files:
    javascripts:
      defaultExtension: 'coffee'
      joinTo:
        'javascripts/app.js': /^app/
        'javascripts/vendor.js': /^vendor/
      order:
        before: [
          'vendor/scripts/console-helper.js'
          'vendor/scripts/jquery.js'
          'vendor/scripts/underscore.js'
          'vendor/scripts/backbone.js'
          'vendor/scripts/backbone.marionette.js'
          'vendor/scripts/bootstrap.js'
          'vendor/scripts/chosen.jquery.min.js'
          'vendor/scripts/q.js'
          'vendor/scripts/jquery.cookie.js'
        ]

    stylesheets:
      defaultExtension: 'styl'
      joinTo: 'stylesheets/app.css'
      order:
        before: [
          'vendor/styles/bootstrap.css'
          'vendor/styles/bootstrap-body.css'
          'vendor/styles/bootstrap-responsive.css'
          'vendor/styles/chosen.min.css'
        ]
        after: []

    templates:
      defaultExtension: 'hbs'
      joinTo: 'javascripts/app.js'
