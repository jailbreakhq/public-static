define [
  "backbone",
  "collections/TeamsCollection"
  "models/TeamModel"
  "views/IndexView"
  "views/TeamView"
], (Backbone, Teams, Team, IndexView, TeamView) ->
  class Router extends Backbone.Router
    routes:
      '':         'index'
      'teams/:id': 'team'

    index: ->
      mainView = new IndexView()

    team: (id) ->
      team = new Team
        id: id
      team.fetch
        success: (team) ->
          teamView = new TeamView(model: team)
          $("#body-container").html(teamView.render().$el)
        error: (collection, response) ->
          alert(response.status + ' ' + response.responseText)
