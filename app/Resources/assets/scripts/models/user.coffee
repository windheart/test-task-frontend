class UserModel extends Backbone.Model

  defaults:
    userName: null
    userBirthday: null
    userGender: null

    userEmail: null
    siteUrl: null

    userPhone: null

    userSkill: null
    userAbout: null

    password: null
    

  url: "/process-form"


  parse: (response) ->
    parsed = {}

    for attrName, valueObj of response
      attr = attrName.replace(/\]\[/g, ".").replace(/\[|\]/g, "").split(".")

      _.reduce(attr,
        (parsedCurrent, attrCurrent, index) ->
          if _.isUndefined(parsedCurrent[attrCurrent])
            if (index + 1) is attr.length
              parsedCurrent[attrCurrent] = valueObj.value
            else
              parsedCurrent[attrCurrent] = {}
          
          return parsedCurrent[attrCurrent]
        parsed
      )

    return parsed
  
  
module.exports = UserModel  
