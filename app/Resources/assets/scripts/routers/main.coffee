MainController = require "./../controllers/main.coffee"
vent = require "./../vent.coffee"


class MainRouter extends Marionette.AppRouter
  
  controller: new MainController 

  appRoutes:
    "": "index"
    "users": "index"
    "users/:id/edit": "edit"


  initialize: ->
    @listenTo(vent, "router:navigate", @proxyNavigate)


  proxyNavigate: (route) ->
    @navigate(route, trigger: true)
    

module.exports = MainRouter    