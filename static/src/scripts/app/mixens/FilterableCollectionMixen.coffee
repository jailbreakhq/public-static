define [
  "jquery"
  "underscore"
], ($, _) ->
  class FilterableCollectionMixen
    filters: null

    initialize: (data, options) ->
      if options
        @filters = options.filters

      super