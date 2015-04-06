define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'mixen'
  'mixens/BaseViewMixen'
  'mixens/CollectionViewMixen'
  'views/TeamItemView'
], ($, _, Backbone, jade, Mixen, BaseView, CollectionView, TeamItemView, FiltersView) ->
  class List extends Mixen(CollectionView, BaseView)
    template: jade.teamsList

    initialize: (options) ->
      super

    render: =>
      context = @getRenderContext()
      @$el.html @template context

      _.each @collection.models, (team) =>
        @renderTeam team
      
      @

    renderTeam: (team) ->
      teamView = new TeamItemView
        model: team
      @rememberView teamView
      $('#teams').append teamView.render().$el
