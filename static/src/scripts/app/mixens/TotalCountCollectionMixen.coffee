define [
  'jquery'
  'underscore'
  'backbone'
], ($, _, backbone, Mixen, AuthMixen, LoadedMixen) ->
  class TotalCountCollection
    totalCount: null

    parse: (resp, options) ->
      super
      # parse out the total count header
      total = options.xhr.getResponseHeader 'X-Total-Count'
      if total
        @totalCount = total
      resp