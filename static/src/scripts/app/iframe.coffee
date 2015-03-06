require [
  "jquery"
  "underscore"
  "foundation"
  "foundation.topbar"
  "raven"
  "collections/TeamsCollection"
  "models/JailbreakModel"
  "views/TeamsMapView"
  "views/TopTeamsCardListView"
  "jquery.countdown"
  "moment"
  "signet"
], ($, _, foundation, topbar, Raven, Teams, Jailbreak, TeamsMapView, TopTeamsCardListiew, countdown, moment) ->
  
  $ ->
    # Config Sentry Raven Client
    if jailbreak.sentry.enabled
      Raven.config(jailbreak.sentry.dsn, {
        whitelistUrls: ['local.jailbreakhq.org', 'builds.jailbreakhq.org']
      }).install();

    # Sentry Foundation javascript events/handlers
    $(document).foundation()

    # Load google map by inserting new script into the page
    require ["async!//maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"], (data) ->
      settings = new Jailbreak
      teams = new Teams

      teamsMapView = new TeamsMapView
        settings: settings
        teams: teams

      topTeamsCardsView = new TopTeamsCardListiew
        collection: teams

      settings.fetch
        success: ->
          teamsMapView.renderMap()

          if moment().utc().unix() < settings.get 'startTime'
            $("#header-countdown").countdown "2015/03/07 09:00:00", (event) ->
              $(this).html event.strftime "Race begins %-D day%!d %H hours %M minutes %S seconds"

          teams.fetch
            success: ->
              teamsMapView.renderTeamMarkers()
              topTeamsCardsView.render()
