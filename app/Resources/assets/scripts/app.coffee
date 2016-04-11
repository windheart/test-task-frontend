global.Marionette = require "backbone.marionette"
global.Backbone = require "backbone"
global.jQuery = global.$ = require "jquery"
global._ = require "underscore"
global.moment = require "moment"

LayoutView = require "./views/layout.coffee" 
MainRouter = require "./routers/main.coffee"

vent = require "./vent.coffee"


class TestApp extends Marionette.Application
  
  layout: new LayoutView

  router: new MainRouter
  

  onStart: ->
    @layout.render()
    Backbone.history.start(pushState: true)

    
(new TestApp).start()