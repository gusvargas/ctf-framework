Challenge = require 'models/Challenge'

class Challenges extends Backbone.Collection
	model: Challenge
	url: 'http://localhost:1337/challenges'

module.exports = Challenges