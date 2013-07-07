class Challenge extends Backbone.Model
	url: -> "http://localhost:1337/challenges/#{@id}"

module.exports = Challenge