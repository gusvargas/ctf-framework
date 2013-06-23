AppLayout = require 'views/AppLayout'
NavView = require 'views/NavView'

class Application extends Backbone.Marionette.Application
    initialize: =>
         
        @on 'initialize:after', (options) =>
            Backbone.history.start();
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

        @start()


module.exports = new Application()
