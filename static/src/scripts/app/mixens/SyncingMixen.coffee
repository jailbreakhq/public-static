define [
  'underscore'
], (_) ->
  class Syncing
    syncing: false
    error: false

    constructor: (data, options) ->
      @.on 'sync',  =>
        @syncing = false
        @trigger 'loaded'
      , @

      @.on 'error', (model, error) =>
        @error = true
        @errorMessage = error.responseJSON?.message
        @errorStatus = error?.status or 500
      , @

    sync: (method, model, options) ->
      @syncing = true
      @trigger 'loading'

      super