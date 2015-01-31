define [
  "backbone",
  "collections/TeamsCollection"
  "models/TeamModel"
  "views/IndexView"
  "views/SingleTeamView"
], (Backbone, Teams, Team, IndexView, SingleTeamView) ->
  class Router extends Backbone.Router
    routes:
      '':         'index'
      'teams/:id': 'team'

    index: ->
      indexView = new IndexView()
      $("#body-container").html indexView.render().$el

    team: (id) ->
      singleTeamView = new SingleTeamView
        teamId: id
      $("#body-container").html singleTeamView.render().$el
