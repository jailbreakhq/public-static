define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "collections/TeamsCollection"
  "models/JailbreakModel"
  "moment"
], ($, _, Backbone, jade, Teams, Jailbreak, moment) ->
  class TeamsMapView extends Backbone.View

    initialize: (options) =>
      @settings = options.settings
      @teams = options.teams

    renderMap: =>
      startLat = @settings.get 'startLocationLat'
      startLon = @settings.get 'startLocationLon'
      finalLat = @settings.get 'finalLocationLat'
      finalLon = @settings.get 'finalLocationLon'

      mapOptions =
        zoom: 14
        center: new google.maps.LatLng startLat, startLon
        mapTypeId: google.maps.MapTypeId.ROADMAP
        streetViewControl: false
        mapTypeControl: false
        panControl: false
        zoomControl: true
      
      @map = new google.maps.Map document.getElementById('map-canvas'), mapOptions
      @markerBounds = new google.maps.LatLngBounds()
      @infowindow = new google.maps.InfoWindow
        content: "Loading..."

      # start and end markers
      @startMarker = new google.maps.Marker
        position: new google.maps.LatLng(startLat, startLon)
        map: @map
        icon:
          path: google.maps.SymbolPath.CIRCLE
          scale: 6
          strokeColor: '#b21c26'
        title: "Start Point"
        html: """<div class="info-window"><h3>Collins Barracks, Dublin</h3><p>The start point of the Jailbreak 2015 race</p></div>"""

      google.maps.event.addListener @startMarker, 'click', (startMarker) =>
        @infowindow.setContent @startMarker.html
        @infowindow.open @map, @startMarker

      @markerBounds.extend @startMarker.position

      if @settings.get 'startTime' > moment.utc().unix()
        # only add marker after the compeition has started
        @endMarker = new google.maps.Marker
          position: new google.maps.LatLng(finalLat, finalLon)
          map: @map
          icon:
            path: google.maps.SymbolPath.CIRCLE
            scale: 6
            strokeColor: '#b21c26'
          title: "Location X"
          html: """<div class="info-window"><h3>Location X</h3><p>The mystery Location X is no longer a mystery!</p></div>"""

        google.maps.event.addListener @endMarker, 'click', (endMarker) =>
          @infowindow.setContent @endMarker.html
          @infowindow.open @map, @endMarker

        @markerBounds.extend @endMarker.position

      # used to force minimum zoom if all competitors at the start position
      @markerBounds.extend (new google.maps.LatLng(53.3471, -6.28789))

      @map.fitBounds(@markerBounds)

      @

    renderTeamMarkers: =>
      markers = []

      _.each @teams.models, (team) =>
        if team.has 'lastCheckin'
          marker = new google.maps.Marker
            position: new google.maps.LatLng(team.get('lastCheckin').get('lat'), team.get('lastCheckin').get('lon'))
            map: @map
            title: team.teamNumber + " " + team.names
            html: jade.mapsMarker team.getRenderContext()
            animation: google.maps.Animation.DROP
  
          markers.push marker

      _.each markers, (marker) =>
        google.maps.event.addListener marker, 'click', =>
          @infowindow.setContent marker.html
          @infowindow.open @map, marker

        @markerBounds.extend marker.position

      @map.fitBounds(@markerBounds)

      @
