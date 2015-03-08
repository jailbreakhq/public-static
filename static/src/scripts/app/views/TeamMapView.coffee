define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "moment"
  "humanize"
], ($, _, Backbone, jade, moment) ->
  class TeamMapView extends Backbone.View

    initialize: (options) =>
      @checkins = options.checkins
      @mapElement = options.mapElement or "map-canvas"

      @listenTo @checkins, "sync", @renderTeamCheckins

    renderMap: =>
      mapOptions =
        zoom: 14
        center: new google.maps.LatLng 53.3498, -6.2603
        mapTypeId: google.maps.MapTypeId.ROADMAP
        streetViewControl: false
        mapTypeControl: false
        panControl: false
        zoomControl: true
      
      @map = new google.maps.Map document.getElementById(@mapElement), mapOptions

    renderTeamMarkers: =>
      markerBounds = new google.maps.LatLngBounds()
      infowindow = new google.maps.InfoWindow
        content: "Loading..."

      markers = []
      route = []

      _.each @checkins.models, (checkin) =>
        marker = new google.maps.Marker
          position: new google.maps.LatLng(checkin.get('lat'), checkin.get('lon'))
          map: @map
          title: checkin.get 'location'
          html: jade.mapsCheckinMarker checkin.getRenderContext()
          animation: google.maps.Animation.DROP
  
        markers.push marker
        route.push new google.maps.LatLng(checkin.get('lat'), checkin.get('lon'))

      _.each markers, (marker) =>
        google.maps.event.addListener marker, 'click', =>
          infowindow.setContent marker.html
          infowindow.open @map, marker

        markerBounds.extend marker.position

      routePath = new google.maps.Polyline
        path: route,
        geodesic: true,
        strokeColor: '#FF0000',
        strokeOpacity: 1.0,
        strokeWeight: 2

      routePath.setMap(@map)

      @map.fitBounds(markerBounds)

      @
