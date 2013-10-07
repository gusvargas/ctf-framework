template = require 'views/templates/challengesLayout'
ChallengeForm = require 'views/ChallengeFormView'
Challenges = require 'collections/Challenges'
ChallengeTable = require 'views/ChallengeTableView'
ChallengeToolbar = require 'views/ChallengeToolbarView'
SearchBox = require 'views/SearchBoxView'
App = require 'application'

class ChallengesLayout extends Backbone.Marionette.Layout
	id: 'challenges-layout'
	template: template

	ui:
		toolbar: '#toolbar-container'

	regions:
		sideBar: '#challenges-sidebar'
		table: '#challenges-container'
		toolBar: '.toolbar-container'
		search: '.search'

	onRender: ->
		@sideBar.show new ChallengeForm
			collection: App.challenges
		@table.show new ChallengeTable
			collection: App.challenges
		@toolBar.show new ChallengeToolbar
		@search.show new SearchBox
			resource: 'challenges'

module.exports = ChallengesLayout

