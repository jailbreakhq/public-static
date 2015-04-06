define [
  'underscore'
  'backbone'
  'mixen'
  'mixens/AuthMixen'
  'mixens/SyncingMixen'
  'jsUri'
], (_, backbone, Mixen, AuthMixen, SyncingMixen, Uri) ->
  class BaseCollection extends Mixen(SyncingMixen, AuthMixen, Backbone.Collection)
    urlRoot: jailbreak.api_host

    initialize: (models, options) ->
      @urlParams = {}
      if options?.limit
        @urlParams['limit'] = options.limit

      super

    url: ->
      super
      uri = new Uri(jailbreak.api_host + @urlPath)
      keys = _.keys @urlParams
      _.each keys, (key) =>
        uri.addQueryParam(key, @urlParams[key])

      uri.toString()

    sync: ->
      # do not remove

      super