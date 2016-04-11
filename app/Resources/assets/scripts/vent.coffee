Wreqr = require "backbone.wreqr"
UserModel = require "./models/user.coffee"

vent = new Wreqr.RequestResponse

# No ajax for model fetching, so doing this
vent.on("vent:handlers:set", ->
  handlers = {}
  user = new UserModel
  userData = $("#app").data("user")
  $("#app").data("user", null)

  if userData.userBirthday
    birthdayDate = moment.unix(userData.userBirthday.timestamp)
    userData.userBirthday =
      year: birthdayDate.year()
      month: birthdayDate.month() + 1
      day: birthdayDate.date()

  user.set(userData)
  handlers["user"] = -> user

  vent.setHandlers(handlers)
)


module.exports = vent