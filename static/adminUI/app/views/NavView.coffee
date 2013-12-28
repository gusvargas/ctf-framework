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

    location = $target.data 'location'

    App.vent.trigger location

  setLocation: (location) ->
    @ui.navItems.removeClass 'active'
    @ui.navItems.find("a[data-location='#{location}']")
                .parent()
                .addClass 'active'


module.exports = NavView
