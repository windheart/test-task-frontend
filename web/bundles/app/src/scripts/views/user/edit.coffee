define 'views/user/edit', [
  'vent'

], (vent) ->

  
  class UserEditView extends Marionette.ItemView

    template: "#templates-user-edit"

    templateHelpers:
      birthday: (data) ->
        return unless data
        moment().year(data.year).month(data.month).date(data.day).format("DD.MM.YYYY")

      gender: (currentValue, checkedValue) ->
        if +currentValue is +checkedValue
          return "checked"

    ui:
      "input" : ".form-control"
      "cancel": "[data-action=cancel]"
      "save"  : "[data-action=save]"

    events:
      "focusin @ui.input" : "toggleLabel"
      "focusout @ui.input": "toggleLabel"

      "click @ui.cancel": "cancel"
      "click @ui.save"  : "save"

    modelEvents:
      "sync": "render"

    validator: null

    validatationOptions:
      rules:
        "user[userName]":
          required: true

        "user[userEmail]":
          required: true

      messages:
        "user[userName]":
          required: "Name required"

        "user[userEmail]":
          required: "Email required"


      highlight: (element) ->
        $(element).parents(".form-group").addClass( "has-error" )

      unhighlight: (element) ->
        $(element).parents(".form-group").removeClass("has-error")

      errorPlacement: (error, element) ->
        error.insertBefore(element.prev("label"))


    initialize: ->
      @model.set($("#app").data("user"))


    onRender: ->
      @validator = @$("form").validate(@validatationOptions)


    cancel: (e) ->
      e.preventDefault()
      vent.trigger("router:navigate", e.currentTarget.pathname)


    save: (e) ->
      e.preventDefault()

      unless @$("form").valid()
        return

      data = Backbone.Syphon.serialize(@)
      data.user.userBirthday = @_prepareBirthday(data.user.userBirthday)

      @model
        .fetch(
          data: data
          method: "POST"

          success: =>
            vent.trigger("router:navigate", "/")

          error: (user, xhr) =>
            @_showErrors(xhr.responseJSON.errors.children)
        )


    toggleLabel: (e) ->
      formGroup = @$(e.currentTarget).parents(".form-group")

      if formGroup.hasClass("has-error")
        return

      @$(e.currentTarget).prev("label").toggleClass("invisible", e.type is "focusout")


    _prepareBirthday: (birthday) ->
      return unless birthday

      date = moment(birthday, "DD.MM.YYYY")

      return {
        year: date.year()
        month: date.month() + 1
        day: date.date()
      }


    _showErrors: (errors) ->
      for attr, error of errors
        continue unless error.errors

        @validator.showErrors(
          "user[#{attr}]": error.errors[0]
        )
