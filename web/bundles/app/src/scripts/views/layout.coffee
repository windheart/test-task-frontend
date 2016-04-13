define 'views/layout', [
  'vent'

], (vent) ->

  
  class LayoutView extends Marionette.LayoutView

    el: "#app"
    
    template: "#templates-layout"

    regions:
      content: "#content-region"
      modal: "#modal-region"


    initialize: ->
      @listenTo(vent, "layout:content:show", @showContent)


    showContent: (view) ->
      @getRegion("content").show(view)
    