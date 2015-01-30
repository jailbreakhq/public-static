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

    initialize: ->
      @index()

    index: ->
      mainView = new IndexView()

    team: (id) ->
      console.log "Route Team(" + id + ")"
      team = new Team
        id: id
      team.fetch
        success: (team) ->
          teamView = new TeamView(model: team)
        error: (collection, response) ->
          alert(response.status + ' ' + response.responseText)
