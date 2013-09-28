App = require 'application'
template = require 'views/templates/searchBox'

class SearchBox extends Backbone.Marionette.ItemView
  template: template
  className: 'search-container'

  events:
    'keyup input[type="search"]': 'search'

  initialize: (attrs) ->
    @resource = attrs.resource

  search: (e) ->
    searchTerm = $(e.target).val().toLowerCase()
    App.vent.trigger "search:#{@resource}", searchTerm

module.exports = SearchBox
