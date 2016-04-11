LayoutTemplate = require "./../templates/layout.ejs"
vent = require "./../vent.coffee"


class LayoutView extends Marionette.LayoutView

  el: "#app"

  template: LayoutTemplate

  regions:
    content: "#content-region"
    modal: "#modal-region"


  initialize: ->
    @listenTo(vent, "layout:content:show", @showContent)
    

  showContent: (view) ->
    @getRegion("content").show(view)


  onRender: ->
    vent.trigger("vent:handlers:set")

    
module.exports = LayoutView
    