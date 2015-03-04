define [
  "backbone",
  "collections/TeamsCollection"
  "models/TeamModel"
  "views/IndexView"
  "views/TeamListView"
  "views/TeamProfileView"
  "views/DonationFormView"
], (Backbone, Teams, Team, IndexView, TeamListView, TeamProfileView, DonationFormView) ->
  class Router extends Backbone.Router
    routes:
      '':                   'index'
      'teams(/)':           'teams'
      'teams/:slug':        'team'
      'donate(/)':          'donate'
      'donate/:slug':     'donateTeam'

    initialize: ->
      require ['google.analytics'], ((data) ->
        window.ga 'create', jailbreak.ga_id
        return
      ), ->
        window.ga = -> # empty function
          return

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
        iphoneRedirect: @_isIphoneRedirect()
      $("#body-container").html donateView.render().$el

    donateTeam: (slug) ->
      team = new Team
        slug: slug
      team.fetch
        success: =>
          donateView = new DonationFormView
            teamId: team.get 'id'
            name: team.get 'names'
            iphoneRedirect: @_isIphoneRedirect()
          $("#body-container").html donateView.render().$el

    _isIphoneRedirect: ->
      url = Backbone.history.getFragment()
      (url.indexOf('iphone') != -1)

    _trackPageview: ->
      try
        url = Backbone.history.getFragment()
        window.ga 'send', 'pageview', "/#{url}"
      catch
        # do nothing - track might be disable by user
