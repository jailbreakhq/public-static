define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "collections/TeamsCollection"
  "collections/DonationsCollection"
  "models/JailbreakModel"
  "views/TeamsMapView"
  "views/TeamItemView"
  "views/DonationsListView"
  "views/IndexStatsView"
  "slick"
  "vex"
  "async"
], ($, _, Backbone, jade, Teams, Donations, Jailbreak, TeamsMapView, TeamItemView, DonationsListView, IndexStatsView, slick, vex) ->
  class Index extends Backbone.View
    template: jade.index

    initialize: =>
      @jailbreakModel = new Jailbreak()
      @jailbreakModel.fetch()

      @teams = new Teams
      @teams.fetch()

      @donations = new Donations
      @donations.fetch()

      @teamsMapView = new TeamsMapView
        settings: @jailbreakModel
        teams: @teams
        mapElement: "index-map-canvas"

      require ["async!//maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"], (data) =>
        @teamsMapView.googleMapsLoaded()

    render: =>
      @$el.html @template()

      @renderDonationsList()

      @renderIndexStatsView()

      @

    afterRender: =>
      @slick()

    countdownTimer: ->
      $("#countdown-timer").countdown "2015/03/07 09:00:00", (event) ->
        $(this).html event.strftime """<ul>
            <li><span>%-D</span> day%!d</li>
            <li><span>%H</span> hours</li>
            <li><span>%M</span> minutes</li>
            <li><span>%S</span> seconds</li>
          </ul>"""

    slick: ->
      $(".video-slick").slick
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
            settings: "unslick"
          }
        ]

    renderDonationsList: =>
      donationsListView = new DonationsListView
        collection: @donations
        template: jade.donations
      $("#all-donations", @$el).append donationsListView.render().$el

    renderIndexStatsView: =>
      indexStatsView = new IndexStatsView
        model: @jailbreakModel
      $("#index-stats", @$el).append indexStatsView.render().$el
