define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'mixen'
  'mixens/BaseViewMixen'
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
], ($, _, Backbone, jade, Mixen, BaseView, Teams, Donations, FeedEvents, Jailbreak, TeamsMapView, TeamItemView, DonationsListView, IndexStatsView, EventsListView, slick) ->
  class Index extends Mixen(BaseView)
    template: jade.index

    initialize: =>
      # start fetching the sub collections
      @jailbreakModel = new Jailbreak
      @jailbreakModel.fetch()

      @teams = new Teams [],
        urlPath: '/teams/all'
      @teams.fetch()

      @eventItems = new FeedEvents [],
        limit: 15
      @eventItems.fetch()

      @donations = new Donations
      @donations.fetch()

      # create views
      @indexStatsView = new IndexStatsView
        model: @jailbreakModel
      @rememberView @indexStatsView

      @eventsListView = new EventsListView
        collection: @eventItems
      @rememberView @eventsListView

      @donationsListView = new DonationsListView
        collection: @donations
        template: jade.donations
      @rememberView @donationsListView

    render: =>
      @$el.html @template()

      # render sub views
      @renderTeamsMapView()
      
      $('#index-stats', @$el).append @indexStatsView.render().$el
      $('#events-stream', @$el).append @eventsListView.render().$el
      $('#all-donations', @$el).append @donationsListView.render().$el

      @slick()

      @

    renderTeamsMapView: =>
      teamsMapView = new TeamsMapView
        settings: @jailbreakModel
        teams: @teams
        mapElement: 'index-map-canvas'
      @rememberView teamsMapView

      require ['async!//maps.googleapis.com/maps/api/js?v=3.exp&sensor=false'], (data) ->
        teamsMapView.googleMapsLoaded()

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
      $('.slick-next', @$el).click()
