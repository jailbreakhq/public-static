define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "collections/TeamsCollection"
  "collections/DonationsCollection"
  "views/TeamItemView"
  "views/DonationsListView"
], ($, _, Backbone, jade, Teams, Donations, TeamItemView, DonationsListView) ->
  class Index extends Backbone.View
    template: jade.index

    initialize: =>
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

    renderTeamsList: =>
      list = $("#featured-teams")

      _.each @teams.models, (team) ->
        teamView = new TeamItemView
          model: team
        list.append teamView.render().$el

    renderDonationsList: =>
      $("#all-donations").append @donationsListView.render().$el

