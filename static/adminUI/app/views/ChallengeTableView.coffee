template = require 'views/templates/challengeTable'
ChallengeRow = require 'views/ChallengeRowView'
App = require 'application'

class ChallengeTable extends Backbone.Marionette.CompositeView
  tagName: 'table'
  className: 'table table-hover table-condensed'
  template: template
  itemView: ChallengeRow
  itemViewContainer: 'tbody'

  ui:
    tbody: 'tbody'

  events:
    'click th': 'sort'

  collectionEvents:
    'sort': 'render'

  sort: (e) ->
    attr = $(e.currentTarget).data 'attr'
    @collection.sortBy(attr) if attr?

module.exports = ChallengeTable