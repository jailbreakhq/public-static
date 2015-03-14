define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'mixen'
  'mixens/CollectionViewMixen'
  'views/TeamItemView'
], ($, _, Backbone, jade, Mixen, CollectionViewMixen, TeamItemView) ->
  class TeamList extends Mixen(CollectionViewMixen, Backbone.View)
    template: jade.teams

    initialize: (options) ->
      super

    render: =>
      context = @getRenderContext()
      @$el.html @template context

      _.each @collection.models, (team) ->
        teamView = new TeamItemView
          model: team
        $('#teams').append teamView.render().$el

      @