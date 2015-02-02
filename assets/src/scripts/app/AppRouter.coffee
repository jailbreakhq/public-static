define [
  "backbone",
  "collections/TeamsCollection"
  "models/TeamModel"
  "views/IndexView"
  "views/TeamProfileView"
], (Backbone, Teams, Team, IndexView, TeamProfileView) ->
  class Router extends Backbone.Router
    routes:
      '':         'index'
      'teams/:id': 'team'

    index: ->
      indexView = new IndexView()
      $("#body-container").html indexView.render().$el

    team: (id) ->
      teamProfileView = new TeamProfileView
        teamId: id
      $("#body-container").html teamProfileView.render().$el
