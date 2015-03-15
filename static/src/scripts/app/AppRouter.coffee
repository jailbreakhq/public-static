define [
  'backbone',
  'collections/TeamsCollection'
  'collections/TeamsByCheckinCollection'
  'models/TeamModel'
  'views/IndexView'
  'views/TeamListView'
  'views/TeamProfileView'
  'views/DonationFormView'
  'views/LoginView'
  'views/admin/MainView'
  'views/admin/AddFeedView'
  'views/ErrorView'
], (Backbone, Teams, TeamsByCheckin, Team, IndexView, TeamListView, TeamProfileView, DonationFormView, LoginView, AdminView, AdminFeedView, ErrorView) ->
  class Router extends Backbone.Router
    routes:
      '':                   'index'
      'teams(/)':           'teams'
      'teams/:slug':        'team'
      'donate(/)':          'donate'
      'donate/:slug':       'donateTeam'
      'login(/)':           'login'
      'admin(/)':           'admin'
      'admin/feed(/)':      'adminFeed'
      '*notFound':          'notFound'

    initialize: ->
      try
        require ['//www.google-analytics.com/analytics.js'], (data) ->
          window?.ga 'create', jailbreak.ga_id
          return
      catch
        # do nothing - user might have blocked tracking scripts

      @bodyContainer = $('#body-container')
      @bind 'route', @_trackPageview

    index: ->
      indexView = new IndexView
      @bodyContainer.html indexView.render().$el
      @_showView indexView

    teams: ->
      teams = new Teams
      teams.fetch()
      teamsView = new TeamListView
        collection: teams
      @_showView teamsView

    team: (slug) ->
      team = new Team
        slug: slug
      team.fetch()
      teamProfileView = new TeamProfileView
        model: team
      @_showView teamProfileView

    donate: ->
      donateView = new DonationFormView
        iphoneRedirect: @_isIphoneRedirect()
      @_showView donateView

    donateTeam: (slug) ->
      team = new Team
        slug: slug
      team.fetch
        success: =>
          donateView = new DonationFormView
            teamId: team.get 'id'
            name: team.get 'names'
            iphoneRedirect: @_isIphoneRedirect()
          @_showView DonationFormView

    login: ->
      loginView = new LoginView
      @_showView loginView

    admin: ->
      teamsByCheckin = new TeamsByCheckin
      teamsByCheckin.fetch()
      adminView = new AdminView
        teams: teamsByCheckin
      @_showView adminView

    adminFeed: ->
      feedView = new AdminFeedView
      @_showView feedView

    notFound: ->
      errorView = new ErrorView
        error: 404

      @_showView errorView

    _showView: (view) ->
      if @currentView
        @currentView?.close()

      @currentView = view

      @bodyContainer.html view.render().$el

    _isIphoneRedirect: ->
      url = Backbone.history.getFragment()
      (url.indexOf('iphone') != -1)

    _trackPageview: ->
      try
        require ['//www.google-analytics.com/analytics.js'], (data) ->
          url = Backbone.history.getFragment()
          window?.ga 'send', 'pageview', '/#{url}'
      catch
        # do nothing - user might have blocked tracking scripts
