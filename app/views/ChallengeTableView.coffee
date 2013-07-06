template = require 'views/templates/challengeTable'
ChallengeRow = require 'views/ChallengeRowView'
Application = require 'application'

class ChallengeTable extends Backbone.Marionette.CompositeView
	tagName: 'table'
	className: 'table table-hover table-condensed'
	template: template
	itemView: ChallengeRow
	itemViewContainer: 'tbody'

	ui:
		tbody: 'tbody'

	onCompositeCollectionRendered: ->
		if @ui.tbody.children().length
			@$el.dataTable
				bPaginate: false
				bLengthChange: false
				bInfo: false
				bAutoWidth: false
				sDom: '<"toolbar">frtip'
				fnDrawCallback: =>
					Application.vent.trigger 'challengeTable:initialized'

module.exports = ChallengeTable