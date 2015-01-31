define [
  "jquery"
  "underscore"
  "backbone"
  "models/TeamModel"
  "views/TeamProfileView"
  "views/DonationsListView"
], ($, _, Backbone, Team, TeamProfileView, DonationsListView) ->
  class SingleTeam extends Backbone.View
    initialize: (options) =>
      @teamView = new TeamProfileView
        teamId: options.teamId

      @donationsView = new DonationsListView
        teamId: options.teamId

    render: =>
      @$el.append(@teamView.render().$el)
      @$el.append(@donationsView.render().$el)

      @      
