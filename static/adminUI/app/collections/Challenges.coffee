Challenge = require 'models/Challenge'

class Challenges extends Backbone.Collection
  model: Challenge
  url: '/api/challenges'

  _sortAttribute: 'points'
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

    return -1 * @_sortDirection if a < b
    return 1 * @_sortDirection if a > b
    return 0

module.exports = Challenges
