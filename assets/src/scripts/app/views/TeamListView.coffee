define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "collections/TeamsCollection"
  "views/TeamItemView"
], ($, _, Backbone, jade, Teams, TeamItemView) ->
  class TeamList extends Backbone.View
    template: jade.teams

    initialize: =>
      @collection = new Teams()
      @collection.on("reset", @render)

      @render()

    render: =>
      @$el.html(@template())

      _.each @collection.models, (team) =>
        teamView = new TeamItemView
          model: team
        $("#teams").append(teamView.render().$el)

      @