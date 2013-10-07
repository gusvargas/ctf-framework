template = require 'views/templates/appLayout'

class AppLayout extends Backbone.Marionette.Layout
	template: template
	el: 'body'

	regions:
		nav: '#nav'
		content: '#content'

module.exports = AppLayout