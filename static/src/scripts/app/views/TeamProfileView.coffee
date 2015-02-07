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
  "vex"
  "autolink"
], ($, _, Backbone, foundation, tabs, jade, Donations, Team, DonationsListView, vex, autolink) ->
  class TeamProfile extends Backbone.View
    template: jade.team
    events:
      'click .team-avatar': 'openLargeAvatar'

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

    openLargeAvatar: (event) =>
      displayVex = =>
        # build context
        data =
          avatarSrc: avatar
        _.extend data, @model.toJSON()

        # use vex to display a dialog
        vex.defaultOptions.className = 'vex-theme-default'
        vex.open
          content: jade.teamAvatar data
          contentClassName: 'wide'
          afterOpen: ($vexContent) ->
            $vexContent.append.$el

      avatar = new Image
      avatar.addEventListener("load", displayVex)
      if @model.get 'avatarLarge'
        # if large avatar we haven't loaded that we should do that now
        avatar.src = @model.get 'avatarLarge'
      else
        avatar.src = @model.get 'avatar'

      
