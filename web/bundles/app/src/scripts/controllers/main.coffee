define 'controllers/main', [
  'views/user'
  'views/user/edit'
  'vent'

], (UserView, UserEditView, vent) ->

  
  class MainController extends Marionette.Object
  
    index: ->
      console.log vent.request("user")
      
      vent.trigger("layout:content:show", new UserView(
        model: vent.request("user")
      ))
      
  
    edit: ->
      vent.trigger("layout:content:show", new UserEditView(
        model: vent.request("user")
      ))
      