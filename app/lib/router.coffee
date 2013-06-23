application = require 'application'
ChallengesLayout = require 'views/ChallengesLayout'

module.exports = class Router extends Backbone.Router
	routes:
		'': 'index'

	index: =>
		cl = new ChallengesLayout()
		application.layout.content.show(cl)
		
