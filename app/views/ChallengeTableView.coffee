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

module.exports = ChallengeTable