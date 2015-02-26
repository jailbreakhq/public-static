define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/AuthMixen"
], ($, _, backbone, Mixen, AuthMixen) ->
  class BaseCollectionMixen extends Mixen(AuthMixen, Backbone.Collection)
    urlRoot: jailbreak.api_host
    totalCount: null

    url: ->
      super
      jailbreak.api_host

    sync: (method, model, options) ->
      super
      console.log 'base collection sync'
      @


    parse: (resp, options) ->
      super
      # parse out the total count header
      total = options.xhr.getResponseHeader("X-Total-Count")
      if total
        @totalCount = total
      resp