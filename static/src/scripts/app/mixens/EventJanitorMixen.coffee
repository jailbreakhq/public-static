define [
  'underscore'
], (_) ->
  class EventJanitor
    rememberView: (view) ->
      @views ?= []
      @views.push view
      view

    close: ->
      @stopListening()

      if @views?
        for view in @views
          view.stopListening()
          view.remove()

      @remove()