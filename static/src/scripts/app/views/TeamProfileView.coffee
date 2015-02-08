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
  "views/DonationFormView"
  "vex"
  "autolink"
], ($, _, Backbone, foundation, tabs, jade, Donations, Team, DonationsListView, DonationFormView, vex, autolink) ->
  class TeamProfile extends Backbone.View
    template: jade.team
    events:
      'click .team-avatar.avatar-large': 'openLargeAvatar'
      'click .donate-button': 'donate'

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
      avatar.src = @model.get 'avatarLarge'

    donate: (event) =>
      donationView = new DonationFormView
        name: @model.get('names')

      vex.defaultOptions.className = 'vex-theme-default'
      vex.open
        content: donationView.render().$el
        contentClassName: 'narrow'
        overlayClosesOnClick: false
        afterOpen: ($vexContent) ->
          $vexContent.append.$el
      
