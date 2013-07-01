template = require 'views/templates/challengesLayout'
NewChallengeView = require 'views/NewChallengeView'

class ChallengesLayout extends Backbone.Marionette.Layout
	id: 'challenges-layout'
	template: template
	
	regions:
		sideBar: '#challenges-sidebar'
		main: '#challanges-container'

	onRender: ->
		@sideBar.show new NewChallengeView

module.exports = ChallengesLayout

