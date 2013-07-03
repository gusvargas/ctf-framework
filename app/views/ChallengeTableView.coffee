template = require 'views/templates/challengeTable'
ChallengeRow = require 'views/ChallengeRowView'

class ChallengeTable extends Backbone.Marionette.CompositeView
	tagName: 'table'
	className: 'table table-striped table-condensed'
	template: template
	itemView: ChallengeRow
	itemViewContainer: 'tbody'

	ui:
		tbody: 'tbody'

	onCompositeCollectionRendered: ->
		@$el.dataTable() if @ui.tbody.children().length

module.exports = ChallengeTable