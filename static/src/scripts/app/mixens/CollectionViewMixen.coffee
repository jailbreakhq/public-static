define [
  'underscore'
], (_) ->
  class CollectionView

    initialize: (options) ->
      if not options.collection
        new Error 'This view needs a collection in the initialize options'
      @collection = options.collection
      @listenTo @collection, 'sync error', =>
        @render()
        @renderCollection?()

    getRenderContext: ->
      context = super ? {}

      data =
        error: @collection.error
        errorMessage: @collection.errorMessage
        errorStatus: @collection.errorStatus
        loaded: @collection.loaded

      _.extend context, data