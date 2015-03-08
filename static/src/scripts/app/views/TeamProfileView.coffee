define [
  "jquery"
  "underscore"
  "backbone"
  "foundation"
  "foundation.tabs"
  "jade.templates"
  "collections/DonationsCollection"
  "collections/EventsCollection"
  "collections/CheckinsCollection"
  "models/TeamModel"
  "views/DonationsListView"
  "views/DonationFormView"
  "views/TeamMapView"
  "views/feed/EventsListView"
  "vex"
  "autolink"
], ($, _, Backbone, foundation, tabs, jade, Donations, FeedEvents, Checkins, Team, DonationsListView, DonationFormView, TeamMapView, EventsListView, vex, autolink) ->
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

          @storyEvents = new FeedEvents [],
            filters:
              teamId: @model.get "id"
          @storyEvents.fetch()
          @renderStoryEvents()

          @checkins = new Checkins [],
            teamId: @model.get "id"
          @checkins.fetch()
          @listenTo @checkins, "sync", @renderTeamMap

    render: =>
      @$el.html @template @model.getRenderContext()

      $(document).foundation() # tabs

      @

    renderDonationsList: =>
      $("#donations-panel").append @donationsListView.render().$el

    renderStoryEvents: =>
      eventsListView = new EventsListView
        collection: @storyEvents
        header: "Our Jailbreak Story"
      $("#team-story", @$el).append eventsListView.render().$el

    renderTeamMap: =>
      require ["async!//maps.googleapis.com/maps/api/js?v=3.exp&sensor=false"], (data) =>
        checkinsMapView = new TeamMapView
          checkins: @checkins
          mapElement: "team-map"
        checkinsMapView.renderMap()
        checkinsMapView.renderTeamMarkers()

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
        teamId: @model.get("id")
        name: @model.get("names")
        parent: @

      vex.defaultOptions.className = 'vex-theme-default'
      $vexContent = vex.open
        content: donationView.render().$el
        contentClassName: 'narrow padding-less'
        overlayClosesOnClick: false
        afterOpen: ($vexContent) ->
          $vexContent.append.$el

      @donateVexId = $vexContent.data().vex.id

    closeDonateVex: =>
      vex.close(@donateVexId)
