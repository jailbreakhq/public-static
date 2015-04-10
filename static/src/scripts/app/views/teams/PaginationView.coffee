define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
], ($, _, Backbone, jade) ->
  class PaginationView extends Backbone.View
    template: jade.teamsPagination
    events:
      'click #load-more-teams': 'loadMore'

    initialize: (options) ->
      super

      @collection = options.collection
      @listenTo @collection, 'sync', @render

    render: =>
      context =
        totalCount: @collection.totalCount
        collectionSize: @collection.length

      @$el.html @template context

      @

    loadMore: (event) ->
      @collection.nextPage()
      @collection.fetch
        remove: false
        add: true