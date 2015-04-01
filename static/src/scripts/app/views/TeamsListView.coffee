define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'mixen'
  'mixens/BaseViewMixen'
  'mixens/CollectionViewMixen'
  'models/FiltersModel'
  'views/TeamItemView'
  'views/FiltersView'
], ($, _, Backbone, jade, Mixen, BaseView, CollectionView, Filters, TeamItemView, FiltersView) ->
  class TeamsList extends Mixen(CollectionView, BaseView)
    template: jade.teams

    initialize: (options) ->
      super
      @filters = options.filters

    render: =>
      context = @getRenderContext()
      @$el.html @template context

      _.each @collection.models, (team) =>
        teamView = new TeamItemView
          model: team
        @rememberView teamView
        $('#teams').append teamView.render().$el

      @renderFilterbar()

      @

    renderFilterbar: ->
      filterbarView = new FiltersView
        collection: @collection
        filters: @filters
      @rememberView filterbarView
      $('#filterbar').append filterbarView.render().$el
    