template = require 'views/templates/challengesLayout'
ChallengeForm = require 'views/ChallengeFormView'
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

	onRender: ->
		@sideBar.show new ChallengeForm
			collection: App.challenges
		@main.show new ChallengeTable
			collection: App.challenges

	setupToolbar: ->
		do @bindUIElements

		toolbarView = new ChallengeToolbar
		@ui.toolbar.html toolbarView.render().el

module.exports = ChallengesLayout

