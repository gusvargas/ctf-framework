template = require './templates/nav'

class NavView extends Backbone.Marionette.ItemView
	template: template
	className: 'navbar-inner'

	events:
		'click .nav li': 'navigate'

	ui:
		navItems: '.nav li'

	navigate: (e) ->
		@ui.navItems.removeClass 'active'
		$(e.currentTarget).addClass 'active'


module.exports = NavView