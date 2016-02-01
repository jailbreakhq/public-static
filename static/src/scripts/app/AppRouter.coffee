define [
  'backbone',
  'collections/TeamsCollection'
  'collections/TeamsByCheckinCollection'
  'models/FiltersModel'
  'models/TeamModel'
  'views/IndexView'
  'views/teams/ListPageView'
  'views/TeamProfileView'
  'views/DonationFormView'
  'views/LoginView'
  'views/admin/MainView'
  'views/admin/AddFeedView'
  'views/ErrorView'
], (Backbone, Teams, TeamsByCheckin, Filters, Team, IndexView, TeamsListPageView, TeamProfileView, DonationFormView, LoginView, AdminView, AdminFeedView, ErrorView) ->
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
          if window.ga
            window.ga?('create', jailbreak.ga_id)
      catch
        # do nothing - user might have blocked tracking scripts

      @bodyContainer = $('#body-container')
      @bind 'route', @_trackPageview

    index: ->
      indexView = new IndexView
      @_showView indexView, ''

    teams: ->
      filters = new Filters
      teams = new Teams [],
        filters: filters
        limit: 20
      teams.fetch()
      teamsView = new TeamsListPageView
        collection: teams
        filters: filters
      @_showView teamsView, 'Teams List'

    team: (slug) ->
      team = new Team
        slug: slug
      team.fetch()
      teamProfileView = new TeamProfileView
        model: team
      @_showView teamProfileView, ''

    donate: ->
      donateView = new DonationFormView
        iphoneRedirect: @_isIphoneRedirect()
      @_showView donateView, 'Donate'

    donateTeam: (slug) ->
      team = new Team
        slug: slug
      team.fetch
        success: =>
          donateView = new DonationFormView
            teamId: team.get 'id'
            name: team.get 'names'
            iphoneRedirect: @_isIphoneRedirect()
          @_showView donateView, "Donate to " + team.get 'names'

    login: ->
      loginView = new LoginView
      @_showView loginView, 'Login'

    admin: ->
      teamsByCheckin = new TeamsByCheckin
      teamsByCheckin.fetch()
      adminView = new AdminView
        teams: teamsByCheckin
      @_showView adminView, 'Admin'

    adminFeed: ->
      feedView = new AdminFeedView
      @_showView feedView, 'Admin'

    notFound: ->
      errorView = new ErrorView
        error: 404

      @_showView errorView, 'Page Not Found'

    _showView: (view, title) ->
      if @currentView?.close
        @currentView.close()

      @currentView = view
      @bodyContainer.html view.render().$el
      @_updateTitle(title)

    _updateTitle: (title) ->
      if title
        sep = ' | '
      else
        sep = ''

      document.title = title + sep + '''JailbreakHQ is a global
        charity race in aid of Amnesty International and St.
        Vincent de Paul'''

    _isIphoneRedirect: ->
      url = Backbone.history.getFragment()
      (url.indexOf('iphone') != -1)

    _trackPageview: ->
      try
        require ['//www.google-analytics.com/analytics.js'], (data) ->
          url = Backbone.history.getFragment()
          window.ga?('send', 'pageview', '/#{url}')
      catch
        # do nothing - user might have blocked tracking scripts
