define [
  'jquery'
  'underscore'
  'backbone'
  'mixen'
  'mixens/AuthMixen'
  'mixens/LoadedMixen'
], ($, _, backbone, Mixen, AuthMixen, LoadedMixen) ->
  class BaseCollection extends Mixen(LoadedMixen, AuthMixen, Backbone.Collection)
    urlRoot: jailbreak.api_host
    totalCount: null

    initialize: (data, options) ->
      super # necessary to not break chain

    url: ->
      super
      jailbreak.api_host

    parse: (resp, options) ->
      super
      # parse out the total count header
      total = options.xhr.getResponseHeader 'X-Total-Count'
      if total
        @totalCount = total
      resp