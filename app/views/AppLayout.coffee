template = require 'views/templates/appLayout'

module.exports = class AppLayout extends Backbone.Marionette.Layout
	template: template
	el: 'body'

	regions:
		nav: '#nav'
		content: '#content'
				