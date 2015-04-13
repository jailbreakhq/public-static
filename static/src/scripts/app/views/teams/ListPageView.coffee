define [
  'jquery'
  'jade.templates'
  'mixen'
  'mixens/BaseViewMixen'
  'views/teams/FilterbarView'
  'views/teams/ListView'
  'views/teams/PaginationView'
], ($, jade, Mixen, BaseView, FilterbarView, ListView, PaginationView) ->
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

      @paginationView = new PaginationView
        collection: options.collection
      @rememberView @paginationView

    render: =>
      @$el.html @template()

      $('#filterbar', @$el).append @filterbarView.render().$el
      $('#teamsList', @$el).append @teamsListView.render().$el
      $('#teams-pagination', @$el).html @paginationView.render().$el

      @