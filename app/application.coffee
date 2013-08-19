AppLayout = require 'views/AppLayout'
NavView = require 'views/NavView'
Challenges = require 'collections/Challenges'

class Application extends Backbone.Marionette.Application
    initialize: =>
        @on 'initialize:after', (options) =>
            Backbone.history.start pushState:true

            if Backbone.history.fragment is ''
                Backbone.history.navigate 'challenges',
                    trigger:true

            # Freeze the object
            Object.freeze? this

        @addInitializer (options) =>
            @layout = new AppLayout()
            @layout.render()

        @addInitializer (options) =>
            # Instantiate the router
            Router = require 'lib/router'
            controller = require 'lib/controller'

            @router = new Router
                controller: controller

        @addInitializer (options) =>
            nv = new NavView()
            @layout.nav.show nv

        @addInitializer (options) =>
            @vent.on 'challenges', =>
                @router.navigate 'challenges'

            @vent.on 'challenges:edit', (challenge) =>
                @router.navigate "challenges/edit/#{challenge.get('id')}"

            @vent.on 'challenges:edit:close', =>
                @router.navigate 'challenges'

        @challenges = new Challenges
        @challenges.fetch().then =>
            @start()


module.exports = new Application()
