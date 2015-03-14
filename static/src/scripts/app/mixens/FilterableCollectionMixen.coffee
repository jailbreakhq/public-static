define [
  'underscore'
], (_) ->
  class FilterableCollection
    filters: null

    initialize: (data, options) ->
      if options
        @filters = options.filters

      super