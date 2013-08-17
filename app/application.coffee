AppLayout = require 'views/AppLayout'
NavView = require 'views/NavView'
Challenges = require 'collections/Challenges'

class Application extends Backbone.Marionette.Application
    initialize: =>
        @on 'initialize:after', (options) =>
            Backbone.history.start pushState:true
            # Freeze the object
            Object.freeze? this

        @addInitializer (options) =>
            @layout = new AppLayout()
            @layout.render()

        @addInitializer (options) =>
            nv = new NavView()
            @layout.nav.show nv

        @addInitializer (options) =>
            # Instantiate the router
            Router = require 'lib/router'
            @router = new Router()

        @addInitializer (options) =>
            @challenges = new Challenges
            @challenges.fetch()

        @start()


module.exports = new Application()
