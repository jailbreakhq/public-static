define [
  'underscore'
], (_) ->
  class PaginatableCollection
    page: 1

    constructor: (models, options) ->
      if options?.page
        @page = options.page

    url: =>
      if @page
        @urlParams['page'] = @page

      super

    nextPage: =>
      @page += 1
