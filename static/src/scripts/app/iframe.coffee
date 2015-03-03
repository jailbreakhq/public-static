require [
  "jquery"
  "underscore"
  "foundation"
  "foundation.topbar"
  "raven"
  "collections/TeamsCollection"
  "models/JailbreakModel"
  "views/TeamsMapView"
], ($, _, foundation, topbar, Raven, Teams, Jailbreak, TeamsMapView) ->
  
  $ ->
    # Config Sentry Raven Client
    if jailbreak.sentry.enabled
      Raven.config(jailbreak.sentry.dsn, {
        whitelistUrls: ['local.jailbreakhq.org', 'builds.jailbreakhq.org']
      }).install();

    # Sentry Foundation javascript events/handlers
    $(document).foundation()

    # Load google map by inserting new script into the page
    script = document.createElement 'script'
    script.type = 'text/javascript'
    script.src = 'http://maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&callback=initializeMaps'
    document.body.appendChild script

  # Google Maps Handler
  window.initializeMaps = ->

    settings = new Jailbreak
    teams = new Teams

    teamsMapView = new TeamsMapView
      settings: settings
      teams: teams
    
    settings.fetch
      success: ->
        teamsMapView.renderMap()

        teams.fetch
          success: ->
            teamsMapView.renderTeamMarkers()
