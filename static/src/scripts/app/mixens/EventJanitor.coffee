define [
  'underscore'
], (_) ->
  class EventJanitor
    rememberView: (view) ->
      @views ?= []
      @views.push view
      view

    undelegateEvents: ->
      @stopListening()

      if @views?
        for view in @views
          view.stopListening()