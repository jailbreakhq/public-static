define [
  "backbone"
], (Backbone) ->
  class RequireLogin

    render: ->
      console.log 'render'
      if localStorage.getItem("apiToken") == null
        # if no token should to login
        # another check elsewhere will see if the token
        # is valid
        window.location =  "//" + jailbreak.url + "/login"

      super
