define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
], ($, _, backbone, Mixen) ->
  class BaseCollection extends Mixen(Backbone.Collection)
    urlRoot: jailbreak.api_host
    totalCount: null
    loaded: false

    initialize: (data, options) =>
      @.on "sync", =>
        @loaded = true
      , @

      @.on "error", (collection, resp, options) ->
        if resp.status == 401
          Backbone.history.navigate "login", true

      super

    url: ->
      super
      jailbreak.api_host

    parse: (resp, options) ->
      super
      # parse out the total count header
      total = options.xhr.getResponseHeader("X-Total-Count")
      if total
        @totalCount = total
      resp