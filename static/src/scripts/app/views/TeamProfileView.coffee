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
        slug: options.teamSlug
      @model.bind "change", @render
      @model.fetch
        success: =>
          @render

          donations = new Donations [],
            filters:
              teamId: @model.get("id")
          @donationsListView = new DonationsListView
            collection: donations
          donations.fetch
            success: @renderDonationsList

    render: =>
      @$el.html @template @model.toJSON()

      $(document).foundation() # tabs

      @

    renderDonationsList: =>
      $("#donations-panel").append @donationsListView.render().$el