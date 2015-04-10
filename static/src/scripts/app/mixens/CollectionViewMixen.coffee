define [
  'underscore'
], (_) ->
  class CollectionView

    initialize: (options) ->
      if not options.collection
        new Error 'This view needs a collection in the initialize options'
      @collection = options.collection
      @listenTo @collection, 'loaded error', =>
        @render()

    getRenderContext: ->
      context = super ? {}

      data =
        error: @collection.error
        errorMessage: @collection.errorMessage
        errorStatus: @collection.errorStatus
        loading: @collection.syncing

      _.extend context, data