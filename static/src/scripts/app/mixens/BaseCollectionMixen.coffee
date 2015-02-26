define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
], ($, _, backbone, Mixen) ->
  class BaseCollectionMixen extends Mixen(Backbone.Collection)
    urlRoot: jailbreak.api_host
    totalCount: null

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