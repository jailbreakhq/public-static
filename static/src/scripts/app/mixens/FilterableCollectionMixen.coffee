define [
  'underscore'
], (_) ->
  class FilterableCollection
    filters: null

    constructor: (models, options) ->
      if options
        @filters = options.filters

        @filters?.on('change', =>
          @page = 1 # reset pagination if it exists
          @.fetch() # when filters change reload the collection
        , @)

    url: =>
      if @filters
        if not _.isEmpty @filters.attributes
          encodedFilters = JSON.stringify @filters.toJSON()
          @urlParams['filters'] = encodedFilters

      super
