require [
  'jquery'
  'underscore'
  'foundation'
  'foundation.topbar'
  'raven'
  'collections/TeamsCollection'
  'models/JailbreakModel'
  'views/TeamsMapView'
  'views/TopTeamsCardListView'
  'moment'
  'signet'
  'async'
], ($, _, foundation, topbar, Raven, Teams, Jailbreak, TeamsMapView, TopTeamsCardListiew, moment) ->
  
  $ ->
    # Config Sentry Raven Client
    if jailbreak.sentry.enabled
      Raven.config(jailbreak.sentry.dsn, {
        whitelistUrls: ['local.jailbreakhq.org', 'builds.jailbreakhq.org']
      }).install();

    # Sentry Foundation javascript events/handlers
    $(document).foundation()

    # Load google map by inserting new script into the page
    @settings = new Jailbreak
    @settings.fetch()

    @teams = new Teams
    @teams.fetch()

    @teamsMapView = new TeamsMapView
      settings: @settings
      teams: @teams

    topTeamsCardsView = new TopTeamsCardListiew
      collection: @teams
    topTeamsCardsView.render()

    require ['async!//maps.googleapis.com/maps/api/js?v=3.exp&sensor=false'], (data) =>
      @teamsMapView.googleMapsLoaded()