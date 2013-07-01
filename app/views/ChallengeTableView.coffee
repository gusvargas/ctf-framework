template = require 'views/templates/challengeTable'
ChallengeRow = require 'views/ChallengeRowView'

class ChallengeTable extends Backbone.Marionette.CompositeView
	tagName: 'table'
	template: template
	itemView: ChallengeRow

	appendHtml: (collectionView, itemView) ->
		collectionView.$('tbody').append(itemView.el)

	onCompositeRendered: ->

module.exports = ChallengeTable