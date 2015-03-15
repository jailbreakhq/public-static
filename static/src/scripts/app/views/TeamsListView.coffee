define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'mixen'
  'mixens/BaseViewMixen'
  'mixens/CollectionViewMixen'
  'views/TeamItemView'
], ($, _, Backbone, jade, Mixen, BaseView, CollectionView, TeamItemView) ->
  class TeamsList extends Mixen(CollectionView, BaseView)
    template: jade.teams
    
    render: =>
      context = @getRenderContext()
      @$el.html @template context

      _.each @collection.models, (team) =>
        teamView = new TeamItemView
          model: team
        @rememberView teamView
        $('#teams').append teamView.render().$el

      @