template = require 'views/templates/challengesLayout'
NewChallengeView = require 'views/NewChallengeView'
Challenges = require 'collections/Challenges'
ChallengeTable = require 'views/ChallengeTableView'

class ChallengesLayout extends Backbone.Marionette.Layout
	id: 'challenges-layout'
	template: template
	
	regions:
		sideBar: '#challenges-sidebar'
		main: '#challenges-container'

	initialize: ->
		@challenges = new Challenges
		@challenges.fetch()

	onRender: ->
		@sideBar.show new NewChallengeView
		@main.show new ChallengeTable
			collection: @challenges

module.exports = ChallengesLayout

