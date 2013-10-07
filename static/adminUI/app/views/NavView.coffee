template = require 'views/templates/nav'

class NavView extends Backbone.Marionette.ItemView
  template: template
  className: 'navbar-inner'

  events:
    'click a': 'navigate'

  ui:
    navItems: '.nav li'

  navigate: (e) ->
    e.preventDefault()

    App = require 'application'
    $target = $(e.currentTarget)

    @ui.navItems.removeClass 'active'
    $target.parent().addClass 'active'

    location = $target.data 'location'
    App.vent.trigger location


module.exports = NavView
