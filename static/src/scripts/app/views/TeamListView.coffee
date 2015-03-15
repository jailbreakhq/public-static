define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'mixen'
  'mixens/BaseViewMixen'
  'mixens/CollectionViewMixen'
  'views/TeamItemView'
], ($, _, Backbone, jade, Mixen, BaseViewMixen, CollectionViewMixen, TeamItemView) ->
  class TeamsList extends Mixen(CollectionViewMixen, BaseViewMixen)
    template: jade.teams

    initialize: (options) ->
      super

    render: =>
      context = @getRenderContext()
      @$el.html @template context

      _.each @collection.models, (team) =>
        teamView = new TeamItemView
          model: team
        @rememberView teamView
        $('#teams').append teamView.render().$el

      @