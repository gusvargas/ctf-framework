template = require 'views/templates/challengesLayout'
NewChallengeView = require 'views/NewChallengeView'
Challenges = require 'collections/Challenges'
ChallengeTable = require 'views/ChallengeTableView'
ChallengeToolbar = require 'views/ChallengeToolbarView'
App = require 'application'

class ChallengesLayout extends Backbone.Marionette.Layout
	id: 'challenges-layout'
	template: template

	ui:
		toolbar: '.toolbar-container'
	
	regions:
		sideBar: '#challenges-sidebar'
		main: '#challenges-container'

	initialize: ->
		@listenTo App.vent, 'challengeTable:initialized', @setupToolbar

		@challenges = new Challenges
		@challenges.fetch()

	onRender: ->
		@sideBar.show new NewChallengeView
		@main.show new ChallengeTable
			collection: @challenges

	setupToolbar: ->
		do @bindUIElements

		toolbarView = new ChallengeToolbar
		@ui.toolbar.html toolbarView.render().el

module.exports = ChallengesLayout

