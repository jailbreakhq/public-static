define [
  "backbone",
  "collections/TeamsCollection"
  "models/TeamModel"
  "views/IndexView"
  "views/TeamListView"
  "views/TeamProfileView"
  "views/DonationFormView"
  "//google-analytics.com/analytics.js"
], (Backbone, Teams, Team, IndexView, TeamListView, TeamProfileView, DonationFormView) ->
  class Router extends Backbone.Router
    routes:
      '':                   'index'
      'teams(/)':           'teams'
      'teams/:slug':        'team'
      'donate(/)':          'donate'
      'donate/:slug':     'donateTeam'

    initialize: ->
      ga('create', jailbreak.ga_id, 'auto')
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

    donate: ->
      donateView = new DonationFormView
      $("#body-container").html donateView.render().$el

    donateTeam: (slug) ->
      team = new Team
        slug: slug
      team.fetch
        success: =>
          donateView = new DonationFormView
            teamId: team.get 'id'
            name: team.get 'names'
          $("#body-container").html donateView.render().$el

    _trackPageview: ->
      url = Backbone.history.getFragment()
      ga('send', 'pageview', "/#{url}")
