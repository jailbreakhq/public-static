define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'collections/TeamsCollection'
  'collections/DonationsCollection'
  'collections/EventsCollection'
  'models/JailbreakModel'
  'views/TeamsMapView'
  'views/TeamItemView'
  'views/DonationsListView'
  'views/IndexStatsView'
  'views/feed/EventsListView'
  'slick'
  'async'
], ($, _, Backbone, jade, Teams, Donations, FeedEvents, Jailbreak, TeamsMapView, TeamItemView, DonationsListView, IndexStatsView, EventsListView, slick) ->
  class Index extends Backbone.View
    template: jade.index

    initialize: =>
      @jailbreakModel = new Jailbreak()
      @jailbreakModel.fetch()

      @teams = new Teams
      @teams.fetch()

      @donations = new Donations
      @donations.fetch()

      @eventItems = new FeedEvents
      @eventItems.fetch()

      @teamsMapView = new TeamsMapView
        settings: @jailbreakModel
        teams: @teams
        mapElement: 'index-map-canvas'

      require ['async!//maps.googleapis.com/maps/api/js?v=3.exp&sensor=false'], (data) =>
        @teamsMapView.googleMapsLoaded()

    render: =>
      @$el.html @template()

      @renderDonationsList()

      @renderIndexStatsView()

      @renderEventsStream()

      @slick()

      @

    slick: ->
      $('.video-slick', @$el).slick
        centerMode: true
        variableWidth: true
        infinite: true
        dots: true
        slidesToShow: 4
        slidesToScroll: 1
        responsive: [
          {
            breakpoint: 1024
            settings:
              slidesToShow: 3
              slidesToScroll: 1
              dots: true
          },
          {
            breakpoint: 640
            settings: 'unslick'
          }
        ]

    renderEventsStream: =>
      eventsListView = new EventsListView
        collection: @eventItems
      $('#events-stream', @$el).append eventsListView.render().$el

    renderDonationsList: =>
      donationsListView = new DonationsListView
        collection: @donations
        template: jade.donations
      $('#all-donations', @$el).append donationsListView.render().$el

    renderIndexStatsView: =>
      indexStatsView = new IndexStatsView
        model: @jailbreakModel
      $('#index-stats', @$el).append indexStatsView.render().$el
