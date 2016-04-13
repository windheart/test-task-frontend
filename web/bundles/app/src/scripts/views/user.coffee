define 'views/user', [
  'vent'

], (vent) ->

  
  class UserView extends Marionette.ItemView
  
    template: "#templates-user"
    
    templateHelpers: ->
      birthday: (data) ->
        return unless data
        moment().year(data.year).month(data.month).date(data.day).format("DD.MM.YYYY")
  
      gender: (data) ->
        return unless data
        if data is 0 then "Male" else "Female"
  
    ui:
      "edit": "[data-action=edit]"
  
    events:
      "click @ui.edit": "edit"
      
    modelEvents:
      "sync": "render"
  
  
    edit: (e) ->
      e.preventDefault()
      vent.trigger("router:navigate", e.currentTarget.pathname)
      
      