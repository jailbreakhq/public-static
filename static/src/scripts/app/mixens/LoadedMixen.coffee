define [
  'jquery'
  'underscore'
], ($, _) ->
  class Loaded
    loaded: false
    error: false

    constructor: (data, options) ->
      @.on 'sync', =>
        @loaded = true
        @trigger 'loaded'
      , @

      @.on 'error', (model, error) =>
        @error = true
        @errorMessage = error.responseJSON?.message
        @errorStatus = error.status
      , @