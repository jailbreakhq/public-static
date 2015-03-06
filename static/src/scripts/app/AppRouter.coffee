define [
  "backbone",
  "collections/TeamsCollection"
  "collections/TeamsByCheckinCollection"
  "models/TeamModel"
  "views/IndexView"
  "views/TeamListView"
  "views/TeamProfileView"
  "views/DonationFormView"
  "views/LoginView"
  "views/AdminView"
  "views/ErrorView"
], (Backbone, Teams, TeamsByCheckin, Team, IndexView, TeamListView, TeamProfileView, DonationFormView, LoginView, AdminView, ErrorView) ->
  class Router extends Backbone.Router
    routes:
      '':                   'index'
      'teams(/)':           'teams'
      'teams/:slug':        'team'
      'donate(/)':          'donate'
      'donate/:slug':       'donateTeam'
      'login(/)':           'login'
      'admin(/)':           'admin'
      '*notFound':          'notFound'

    initialize: ->
      try
        require ['//www.google-analytics.com/analytics.js'], (data) ->
        window.ga 'create', jailbreak.ga_id
        return
      catch
        # do nothing - user might have blocked tracking scripts

      @bind 'route', @_trackPageview

    index: ->
      indexView = new IndexView()
      $("#body-container").html indexView.render().$el
      indexView.afterRender()

    teams: ->
      teams = new Teams()
      teams.fetch()
      teamsView = new TeamListView
        collection: teams
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

    login: ->
      loginView = new LoginView
      $("#body-container").html loginView.render().$el

    admin: ->
      teamsByCheckin = new TeamsByCheckin
      teamsByCheckin.fetch()
      adminView = new AdminView
        teams: teamsByCheckin
      $("#body-container").html adminView.render().$el

    notFound: ->
      errorView = new ErrorView
        error: 404

      $("#body-container").html errorView.render().$el

    _isIphoneRedirect: ->
      url = Backbone.history.getFragment()
      (url.indexOf('iphone') != -1)

    _trackPageview: ->
      try
        require ['//www.google-analytics.com/analytics.js'], (data) ->
          url = Backbone.history.getFragment()
          window.ga 'send', 'pageview', "/#{url}"
      catch
        # do nothing - user might have blocked tracking scripts
