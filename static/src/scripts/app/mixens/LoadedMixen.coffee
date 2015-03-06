define [
  "jquery"
], ($) ->
  class Loaded
    loaded: false

    initialize: (data, options) ->
      @.on "sync", =>
        @loaded = true
      , @

      super
