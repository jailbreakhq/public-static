define [
  'underscore'
], (_) ->
  class PaginatableCollection

    constructor: (models, options) ->
      if options?.page
        @page = options.page

    url: =>
      if @page
        @urlParams['page'] = @page

      super

    nextPage: =>
      @page = (@page or 1) + 1
