define [
  'underscore'
], (_) ->
  class Auth

    constructor: ->
      @.on 'error', (collection, resp, options) ->
        if resp.status == 401 or resp.status == 419
          # unauthorized or authentication token expired
          Backbone.history.navigate 'login', true
          localStorage.removeItem 'apiToken'

    sync: (method, model, options) ->
      if localStorage.getItem('apiToken') != null
        apiToken = JSON.parse localStorage.getItem 'apiToken'
        token = "#{apiToken.userId}:#{apiToken.apiToken}"
        tokenB64 = btoa(token)
        authHeaders =
          'Authorization': "Basic #{tokenB64}"

        # ensure we don't overwrite any headers in options by merging our Auth headers in
        options.headers = options.headers or {}
        _.extend options.headers, authHeaders

      super