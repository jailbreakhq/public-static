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
], ($, _, Backbone, jade, Teams, Donations, Jailbreak, TeamItemView, DonationsListView, IndexStatsView, countdown) ->
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

    countdownTimer: ->
      $('#countdown-timer').countdown '2015/03/07 09:00:00', (event) ->
        $(this).html(event.strftime('''<ul>
            <li><span>%-D</span> day%!d</li>
            <li><span>%H</span> hours</li>
            <li><span>%M</span> minutes</li>
            <li><span>%S</span> seconds</li>
          </ul>'''))

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

