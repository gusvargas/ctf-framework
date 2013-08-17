Application = require 'application'
ChallengesLayout = require 'views/ChallengesLayout'

class Router extends Backbone.Router
	routes:
		'': 'index'

	index: ->
		cl = new ChallengesLayout()
		Application.layout.content.show(cl)

module.exports = Router