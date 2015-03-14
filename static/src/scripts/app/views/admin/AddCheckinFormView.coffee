define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'models/PositionModel'
  'models/CheckinModel'
  'ladda'
], ($, _, Backbone, jade, Position, Checkin, Ladda) ->
  class AddCheckinForm extends Backbone.View
    template: jade.adminAddCheckin
    events:
      'click #submit-add-checkin': 'addCheckin'
    
    initialize: (options) =>
      if not options.team
        throw new Error('AddCheckinView requires a team id')
      @team = options.team

      @parent = options.parent

      @position = new Position
      @listenTo @position, 'change', @renderInputs

      # Load google map by inserting new script into the page
      require ['async!//maps.googleapis.com/maps/api/js?v=3.exp&sensor=false&libraries=places'], (data) =>
        @renderMap()

      super

    render: =>
      @$el.html @template()

      @renderInputs()

      @

    renderInputs: =>
      $('#position-inputs', @$el).html jade.adminAddCheckinInputs @position.toJSON()

    renderMap: =>
      if @team.has 'lastCheckin'
        centerLat = @team.get('lastCheckin').get 'lat'
        centerLon = @team.get('lastCheckin').get 'lon'
      else
        centerLat = 53.348857
        centerLon = -6.285844

      mapOptions =
        zoom: 10
        center: new google.maps.LatLng centerLat, centerLon
        mapTypeId: google.maps.MapTypeId.ROADMAP
        streetViewControl: false
        mapTypeControl: false
        panControl: false
        zoomControl: true
      
      map = new google.maps.Map document.getElementById('map-canvas'), mapOptions
      infowindow = new google.maps.InfoWindow
        content: 'Loading...'

      input = document.getElementById 'input-autocomplete'

      map.controls[google.maps.ControlPosition.TOP_LEFT].push(input)

      autocomplete = new google.maps.places.Autocomplete input
      autocomplete.bindTo 'bounds', map

      marker = new google.maps.Marker
        map: map,
        anchorPoint: new google.maps.Point(0, -29)

      google.maps.event.addListener autocomplete, 'place_changed', =>
        infowindow.close()

        place = autocomplete.getPlace()
        if not place.geometry
          return

        # If the place has a geometry, then present it on a map.
        if place.geometry.viewport
          map.fitBounds(place.geometry.viewport)
        else
          map.setCenter(place.geometry.location)
          map.setZoom(17) # Why 17? Because it looks good.
      
        marker.setIcon
          url: place.icon,
          size: new google.maps.Size(71, 71)
          origin: new google.maps.Point(0, 0)
          anchor: new google.maps.Point(17, 34)
          scaledSize: new google.maps.Size(35, 35)

        marker.setPosition(place.geometry.location)
        marker.setVisible(true)

        address = ''
        if place.address_components
          address = [
            (place.address_components[0] && place.address_components[0].short_name || ''),
            (place.address_components[1] && place.address_components[1].short_name || ''),
            (place.address_components[2] && place.address_components[2].short_name || '')
          ].join(' ')

        infowindow.setContent('<div><strong>' + place.name + '</strong><br>' + address)
        infowindow.open map, marker

        location = place.name
        if place.address_components[3]
          location += ', ' + place.address_components[3].long_name
        else if place.vicinity
          location += ', ' + place.vicinity

        # update the model and re-render the actual input fields
        @position.set 'lat', place.geometry.location.k
        @position.set 'lon', place.geometry.location.D
        @position.set 'location', location

    addCheckin: (event) ->
      event.preventDefault()

      data =
        lat: parseFloat $('#input-lat', @$el).val()
        lon: parseFloat $('#input-lon', @$el).val()
        location: $('#input-location', @$el).val()
        status: $('#input-status', @$el).val()
        teamId: @team.get 'id'

      l = Ladda.create document.getElementById 'submit-add-checkin'
      l.start()

      valid = true
      if not @checkField data.lat, '#input-lat'
        valid = false

      if not @checkField data.lon, '#input-lon'
        valid = false

      if not @checkField data.location, '#input-location'
        valid = false

      if not @checkField data.status, '#input-status'
        valid = false

      if not valid
        $('form', @$el).animo
          animation: 'shake-subtle'
          duration: 0.5
        l.stop()
        return false

      checkin = new Checkin data
      checkin.save {},
        success: (model, response) =>
          checkin.set 'distanceToX', response.distanceToX
          checkin.set 'id', response.id
          @team.set 'lastCheckin', checkin
          l.stop()
          @parent.closeVex()
        error: (model, error) =>
          l.stop()
          $('form', @$el).animo
            animation: 'shake-subtle'
            duration: 0.5

    checkField: (value, selector) ->
      if not value
        $(selector, @$el).addClass 'error-field'
        return false
      else
        $(selector, @$el).removeClass 'error-field'
        return true
