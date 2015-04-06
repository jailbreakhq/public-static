define [
  'jquery'
  'jade.templates'
  'mixen'
  'mixens/BaseViewMixen'
  'views/teams/FilterbarView'
  'views/teams/ListView'
], ($, jade, Mixen, BaseView, FilterbarView, ListView) ->
  class TeamsListPageView extends Mixen(BaseView)
    template: jade.teamsPage

    initialize: (options) ->
      super

      @filterbarView = new FilterbarView
        collection: options.collection
        filters: options.filters
      @rememberView @filterbarView

      @teamsListView = new ListView
        collection: options.collection
      @rememberView @teamsListView

    render: =>
      @$el.html @template()

      $('#filterbar', @$el).append @filterbarView.render().$el
      $('#teamsList', @$el).append @teamsListView.render().$el

      @