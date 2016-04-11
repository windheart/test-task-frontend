vent = require "./../vent.coffee"

UserView  = require "./../views/user.coffee"
UserEditView = require "./../views/user/edit.coffee"


class MainController extends Marionette.Object

  index: ->
    vent.trigger("layout:content:show", new UserView(
      model: vent.request("user")
    ))
    

  edit: ->
    vent.trigger("layout:content:show", new UserEditView(
      model: vent.request("user")
    ))
  

module.exports = MainController    