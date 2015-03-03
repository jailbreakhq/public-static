require [
  "jquery"
  "underscore"
  "jade.templates"
  "foundation"
  "foundation.topbar"
  "raven"
], ($, _, jade, foundation, topbar, Raven) ->
  
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
    $.getJSON jailbreak.api_host, (settings) ->
      startLat = settings.startLocationLat
      startLon = settings.startLocationLon
      finalLat = settings.finalLocationLat
      finalLon = settings.finalLocationLon

      mapOptions =
        zoom: 5
        center: new google.maps.LatLng ((startLat+finalLat)/2), ((startLon+finalLon)/2)
        mapTypeId: google.maps.MapTypeId.ROADMAP
        streetViewControl: false
      
      map = new google.maps.Map document.getElementById('map-canvas'), mapOptions
      markerBounds = new google.maps.LatLngBounds()
      infowindow = new google.maps.InfoWindow
        content: "Loading..."

      # start and end markers
      startMarker = new google.maps.Marker
        position: new google.maps.LatLng(startLat, startLon)
        map: map
        title: "Start Point"
        html: "<div class=\"info-window\"><h3>Collins Barracks, Dublin</h3><p>The start point of the Jailbreak 2015 race</p></div>"

      endMarker = new google.maps.Marker
        position: new google.maps.LatLng(finalLat, finalLon)
        map: map
        title: "Location X"
        html: "<div class=\"info-window\"><h3>Location X</h3><p>The mystery Location X is no longer a mystery!</p></div>"

      google.maps.event.addListener startMarker, 'click', ->
        infowindow.setContent this.html
        infowindow.open map, this

      google.maps.event.addListener endMarker, 'click', ->
        infowindow.setContent this.html
        infowindow.open map, this

      markerBounds.extend startMarker.position
      markerBounds.extend endMarker.position

      $.getJSON jailbreak.api_host + "/teams", (teams) ->
        markers = []

        _.each teams, (team) ->
          if _.has team, 'lastCheckin'
            marker = new google.maps.Marker
              position: new google.maps.LatLng(team.lastCheckin.lat, team.lastCheckin.lon)
              map: map
              title: team.teamNumber + " " + team.names
              html: jade.mapsMarker team
    
            markers.push marker

        _.each markers, (marker) ->
          google.maps.event.addListener marker, 'click', ->
            infowindow.setContent this.html
            infowindow.open map, this

          markerBounds.extend marker.position
