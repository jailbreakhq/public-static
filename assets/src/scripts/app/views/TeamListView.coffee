define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "collections/TeamsCollection"
  "views/TeamView"
], ($, _, Backbone, jade, Teams, TeamView) ->
  class TeamListView extends Backbone.View
    template: jade.teams

    initialize: =>
      @collection = new Teams()
      @collection.on("reset", @render)
      @collection.fetch
        success: @render

      @render()

    render: =>
      @$el.html(@template())

      _.each @collection.models, (team) =>
        teamView = new TeamView
          model: team
        $("#teams").append(teamView.render().$el)

      @