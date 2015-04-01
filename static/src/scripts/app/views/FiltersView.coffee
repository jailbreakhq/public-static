define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
], ($, _, Backbone, jade) ->
  class FiltersView extends Backbone.View
    template: jade.filters
    events:
      'change #university': 'changeUniversity'
      'change #order-by': 'changeOrderBy'

    initialize: (options) =>
      @collection = options.collection
      @filters = options.filters

    render: =>
      @$el.html @template @filters.toJSON()

      @

    changeUniversity: (event) ->
      value = $(event.target).val()
      if value == 'ALL'
        @filters.unset 'university'
      else
        @filters.set 'university', value

    changeOrderBy: (event) ->
      @filters.set 'orderBy', $(event.target).val()