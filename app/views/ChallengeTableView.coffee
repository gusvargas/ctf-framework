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

	initialize: ->
		@listenTo App.vent, 'removeRow', @removeRow

	onCompositeCollectionRendered: ->
		if @ui.tbody.children().length
			@dataTable = @$el.dataTable
				bPaginate: false
				bLengthChange: false
				bInfo: false
				bAutoWidth: false
				sDom: '<"toolbar-container">frtip'
				fnDrawCallback: =>
					App.vent.trigger 'challengeTable:initialized'

	removeRow: (row) ->
		@dataTable.fnDeleteRow row

module.exports = ChallengeTable