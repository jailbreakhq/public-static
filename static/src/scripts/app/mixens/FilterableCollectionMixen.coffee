define [
  'underscore'
], (_) ->
  class FilterableCollection
    filters: null

    constructor: (data, options) ->
      if options
        @filters = options.filters