define [
  'underscore'
], (_) ->
  class FilterableCollection
    filters: null

    constructor: (data, options) ->
      if options
        @filters = options.filters

      @filters.on 'change', =>
        @.fetch() # when filters change reload the collection
      , @