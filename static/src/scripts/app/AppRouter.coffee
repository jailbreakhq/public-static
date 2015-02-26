define [
  "backbone",
  "collections/TeamsCollection"
  "models/TeamModel"
  "views/IndexView"
  "views/TeamListView"
  "views/TeamProfileView"
  "google.analytics"
], (Backbone, Teams, Team, IndexView, TeamListView, TeamProfileView) ->
  class Router extends Backbone.Router
    routes:
      '':             'index'
      'teams(/)':       'teams'
      'teams/:slug':  'team'

    initialize: ->
      ga('create', jailbreak.ga_id, 'auto');
      @bind 'route', @_trackPageview

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

    _trackPageview: ->
      url = Backbone.history.getFragment()
      ga('send', 'pageview', "/#{url}");
