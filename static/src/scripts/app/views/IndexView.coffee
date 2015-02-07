define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "collections/TeamsCollection"
  "collections/DonationsCollection"
  "models/JailbreakModel"
  "views/TeamItemView"
  "views/DonationsListView"
  "views/IndexStatsView"
  "jquery.countdown"
  "slick"
], ($, _, Backbone, jade, Teams, Donations, Jailbreak, TeamItemView, DonationsListView, IndexStatsView, countdown, slick) ->
  class Index extends Backbone.View
    template: jade.index

    initialize: =>
      jailbreakModel = new Jailbreak()
      @indexStatsView = new IndexStatsView
        model: jailbreakModel
      jailbreakModel.fetch
        success: @renderIndexStatsView

      @teams = new Teams [],
        filters:
          featured: true
      @teams.fetch
        success: @renderTeamsList

      donations = new Donations
      donations.fetch
        success: @renderDonationsList
      @donationsListView = new DonationsListView
        collection: donations

      @render()

    render: =>
      @$el.html @template()

      @

    afterRender: =>
      @countdownTimer()

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
            breakpoint: 600
            settings:
              slidesToShow: 2
              slidesToScroll: 2
          },
          {
            breakpoint: 400
            settings: "unslick"
          }
        ]

    renderTeamsList: =>
      list = $("#featured-teams")

      _.each @teams.models, (team) ->
        teamView = new TeamItemView
          model: team
        list.append teamView.render().$el

    renderDonationsList: =>
      $("#all-donations").append @donationsListView.render().$el

    renderIndexStatsView: =>
      $("#index-stats").append @indexStatsView.render().$el

