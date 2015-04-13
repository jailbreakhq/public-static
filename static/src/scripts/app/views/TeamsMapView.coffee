define [
  'underscore'
  'jade.templates'
  'moment'
  'humanize'
], (_, jade, moment) ->
  class TeamsMapView extends Backbone.View

    #
    # WARNING: Potential Race Conditions
    #
    # The renderStartFinish and renderTeamMarkers functions need
    # to be called after the googleMapsLoaded function. renderStartFinish
    # can only be called after the @setting data response from the API.
    # similarly the renderTeamMarkers function can only be called after
    # the @teams response from the API is received
    #

    initialize: (options) =>
      @settings = options.settings
      @teams = options.teams

      # async load flags
      @error = false
      @createdMap = false
      @delayedStartFinish = false
      @delayedTeamMarkers = false

      @listenTo @settings, 'sync', @renderStartFinish
      @listenTo @teams, 'sync', @renderTeamMarkers

      @listenTo @settings, 'error', @renderError

      @mapElement = options.mapElement or 'map-canvas'

    googleMapsLoaded: =>
      if @error
        return

      @createdMap = true

      mapOptions =
        zoom: 6
        center: new google.maps.LatLng 53.349, -6.260
        mapTypeId: google.maps.MapTypeId.ROADMAP
        streetViewControl: false
        mapTypeControl: false
        panControl: false
        zoomControl: true
      
      @map = new google.maps.Map document.getElementById(@mapElement), mapOptions
      @markerBounds = new google.maps.LatLngBounds
      @infowindow = new google.maps.InfoWindow
        content: 'Loading...'

      # check if the data dependencies have already
      # return results and we need to call their
      # callback functions again
      if @delayedStartFinish
        @renderStartFinish()

      if @delayedTeamMarkers
        @renderTeamMarkers()

    renderStartFinish: =>
      if not @createdMap
        @delayedStartFinish = true
        return
      
      startLat = @settings.get 'startLocationLat'
      startLon = @settings.get 'startLocationLon'
      finalLat = @settings.get 'finalLocationLat'
      finalLon = @settings.get 'finalLocationLon'

      # start and end markers
      startMarkerContext =
        title: 'Collins Barracks Dublin'
        description: 'The start point of the Jailbreak 2015 race'
      @startMarker = new google.maps.Marker
        position: new google.maps.LatLng startLat, startLon
        map: @map
        icon:
          path: google.maps.SymbolPath.CIRCLE
          scale: 6
          strokeColor: '#b21c26'
        title: 'Start Point'
        html: jade.mapsPosition startMarkerContext

      google.maps.event.addListener @startMarker, 'click', (startMarker) =>
        @infowindow.setContent @startMarker.html
        @infowindow.open @map, @startMarker

      @markerBounds.extend @startMarker.position

      # only add marker after the compeition has started
      endMarkerContext =
        title: 'Location X'
        description: 'Bled Castle overlooking Lake Bled, Slovenia!'
        imageUrl: 'https://static.jailbreakhq.org/bled-castle.jpg'
      @endMarker = new google.maps.Marker
        position: new google.maps.LatLng finalLat, finalLon
        map: @map
        icon:
          path: google.maps.SymbolPath.CIRCLE
          scale: 6
          strokeColor: '#b21c26'
        title: 'Location X'
        html: jade.mapsPosition endMarkerContext

      google.maps.event.addListener @endMarker, 'click', (endMarker) =>
        @infowindow.setContent @endMarker.html
        @infowindow.open @map, @endMarker

      @markerBounds.extend @endMarker.position

      # used to force minimum zoom if all competitors at the start position
      @markerBounds.extend (new google.maps.LatLng(53.3471, -6.28789))

      @map.fitBounds(@markerBounds)

    renderTeamMarkers: =>
      if not @createdMap
        @delayedTeamMarkers = true
        return

      _.each @teams.models, (team) =>
        if team.has 'lastCheckin'
          marker = new google.maps.Marker
            position: new google.maps.LatLng team.get('lastCheckin').get('lat'), team.get('lastCheckin').get('lon')
            map: @map
            title: team.teamNumber + ' ' + team.names
            html: jade.mapsMarker team.getRenderContext()
            animation: google.maps.Animation.DROP
  
          google.maps.event.addListener marker, 'click', =>
            @infowindow.setContent marker.html
            @infowindow.open @map, marker

          @markerBounds.extend marker.position

      @map.fitBounds(@markerBounds)

    renderError: =>
      @error = true
      console.log jade
      $("##{@mapElement}").html jade.mapsFailure()
