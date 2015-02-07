define [
  "backbone",
  "collections/TeamsCollection"
  "models/TeamModel"
  "views/IndexView"
  "views/TeamListView"
  "views/TeamProfileView"
], (Backbone, Teams, Team, IndexView, TeamListView, TeamProfileView) ->
  class Router extends Backbone.Router
    routes:
      '':             'index'
      'teams(/)':       'teams'
      'teams/:slug':  'team'

    index: ->
      indexView = new IndexView()
      $("#body-container").html indexView.render().$el
      indexView.afterRender()

    teams: ->
      teams = new Teams()
      teamsView = new TeamListView
        collection: teams
      teams.fetch
        success: teamsView.render
      $("#body-container").html teamsView.render().$el

    team: (slug) ->
      teamProfileView = new TeamProfileView
        teamSlug: slug
      $("#body-container").html teamProfileView.render().$el
