define [
  'backbone'
  'moment'
], (Backbone, moment) ->
  class RequireLogin

    render: ->
      tokenJSON = localStorage.getItem 'apiToken'
      token = JSON.parse tokenJSON

      if tokenJSON == null or (token.expires < moment().utc().unix())
        # if no token should to login
        # another check elsewhere will see if the token
        # is valid
        window.location =  "//#{jailbreak.url}/login"

      super
