template = require './templates/nav'

class NavView extends Backbone.Marionette.ItemView
	template: template
	className: 'navbar-inner'

module.exports = NavView