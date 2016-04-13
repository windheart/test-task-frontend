require [
  'views/layout'
  'routers/main'
  'models/user'
  'vent'



], (LayoutView, MainRouter, UserModel, vent) ->
  

  class TestApp extends Marionette.Application
    
    layout: new LayoutView
  
    router: new MainRouter


    onStart: ->
      user = new UserModel(window.appData.user)
      vent.setHandler("user", -> user)

      @layout.render()
      Backbone.history.start(pushState: true)
      
   
  window.app = new TestApp     
  window.app.start()