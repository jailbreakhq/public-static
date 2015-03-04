define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "views/TeamItemView"
], ($, _, Backbone, jade, TeamItemView) ->
  class TeamList extends Backbone.View
    template: jade.teams

    initialize: (options) =>
      if not options.collection
        new Error("TeamList view needs a collection in it's options")
      @collection = options.collection
      @.listenTo @collection, "sync", @render

    render: =>
      data =
        loaded: @collection.loaded

      @$el.html @template data

      _.each @collection.models, (team) ->
        teamView = new TeamItemView
          model: team
        $("#teams").append teamView.render().$el

      @