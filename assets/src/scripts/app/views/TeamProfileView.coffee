define [
  "jquery"
  "underscore"
  "backbone"
  "foundation"
  "foundation.tabs"
  "jade.templates"
  "models/TeamModel"
  "views/DonationsListView"
  "autolink"
], ($, _, Backbone, foundation, tabs, jade, Team, DonationsListView, autolink) ->
  class TeamProfile extends Backbone.View
    template: jade.team

    initialize: (options) =>
      @model = new Team
        id: options.teamId
      @model.bind "change", @render
      @model.fetch
        success: @render

      @donationsListView = new DonationsListView
        teamId: options.teamId

    render: =>
      @$el.html @template @model.toJSON()

      $("#donations-panel").append @donationsListView.render().$el

      $(document).foundation() # tabs

      @