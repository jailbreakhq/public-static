define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
], ($, _, backbone, Mixen) ->
  backboneSync = Backbone.sync

  Backbone.sync = (method, model, options) ->
    if localStorage.getItem("apiToken") != null
      apiToken = JSON.parse(localStorage.getItem "apiToken")
      token = apiToken.userId + ':' + apiToken.apiToken
      tokenB64 = btoa(token)
      authHeaders =
        "Authorization": "Basic " + tokenB64

      # ensure we don't overwrite any headers in options by merging our Auth headers in
      options.headers = options.headers or {}
      _.extend options.headers, authHeaders

    backboneSync method, model, options

  class Auth
    loaded: false

    initialize: (data, options) ->
      @.on "error", (collection, resp, options) ->
        if resp.status == 401
          Backbone.history.navigate "login", true
          localStorage.removeItem("apiToken")

      super