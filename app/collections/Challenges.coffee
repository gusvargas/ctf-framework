Challenge = require 'models/Challenge'

class Challenges extends Backbone.Collection
  model: Challenge
  url: 'http://localhost:1337/challenges'

  _sortAttribute: 'name'
  _sortDirection: 1

  sortBy: (attr) ->
    if attr is @_sortAttribute
      @_sortDirection *= -1
    else
      @_sortAttribute = attr
      @_sortDirection = 1

    @sort()

  comparator: (a, b) ->
    a = a.get(@_sortAttribute).toString().toLowerCase()
    b = b.get(@_sortAttribute).toString().toLowerCase()

    return 0 if a is b

    if @_sortDirection is 1
      return a > b ? 1 : -1

    a < b ? 1 : -1

module.exports = Challenges