template = require 'views/templates/challengesLayout'
NewChallengeView = require 'views/NewChallengeView'
Challenges = require 'collections/Challenges'
ChallengeTable = require 'views/ChallengeTableView'
Application = require 'application'

class ChallengesLayout extends Backbone.Marionette.Layout
	id: 'challenges-layout'
	template: template

	ui:
		toolbar: '.toolbar'
	
	regions:
		sideBar: '#challenges-sidebar'
		main: '#challenges-container'

	initialize: ->
		Application.vent.on 'challengeTable:initialized', @setupToolbar, @

		@challenges = new Challenges
		@challenges.fetch()

	onRender: ->
		@sideBar.show new NewChallengeView
		@main.show new ChallengeTable
			collection: @challenges

	setupToolbar: ->
		do @bindUIElements

		@ui.toolbar.html 'This is the toolbar'

module.exports = ChallengesLayout

