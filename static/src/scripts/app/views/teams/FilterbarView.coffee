define [
  'jquery'
  'jade.templates'
  'mixen'
  'mixens/BaseViewMixen'
], ($, jade, Mixen, BaseView) ->
  class Filterbar extends Mixen(BaseView)
    template: jade.teamsFilterbar
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