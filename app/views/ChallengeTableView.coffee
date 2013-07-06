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

	events:
		'change input': 'handleChallengeSelect'

	onCompositeCollectionRendered: ->
		if @ui.tbody.children().length
			@$el.dataTable
				bPaginate: false
				bLengthChange: false
				bInfo: false
				bAutoWidth: false
				sDom: '<"toolbar-container">frtip'
				aoColumnDefs: [
					aTargets: [0]
					mData: null
					sDefaultContent: "<input type='checkbox'>"
				]
				fnDrawCallback: =>
					Application.vent.trigger 'challengeTable:initialized'

	handleChallengeSelect: ->

module.exports = ChallengeTable