define [
  "jquery"
  "underscore"
  "backbone"
  "foundation"
  "foundation.tabs"
  "jade.templates"
  "collections/DonationsCollection"
  "models/TeamModel"
  "views/DonationsListView"
  "autolink"
], ($, _, Backbone, foundation, tabs, jade, Donations, Team, DonationsListView, autolink) ->
  class TeamProfile extends Backbone.View
    template: jade.team

    initialize: (options) =>
      @model = new Team
        id: options.teamId
      @model.bind "change", @render
      @model.fetch
        success: @render

      donations = new Donations [],
        filters:
          teamId: options.teamId
      @donationsListView = new DonationsListView
        collection: donations
      donations.fetch
        success: @render

    render: =>
      @$el.html @template @model.toJSON()

      $("#donations-panel").append @donationsListView.render().$el

      $(document).foundation() # tabs

      @