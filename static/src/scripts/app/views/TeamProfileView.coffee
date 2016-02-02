define [
  'jquery'
  'underscore'
  'backbone'
  'foundation'
  'foundation.tabs'
  'jade.templates'
  'mixen'
  'mixens/BaseViewMixen'
  'mixens/ModelViewMixen'
  'collections/DonationsCollection'
  'collections/EventsCollection'
  'collections/CheckinsCollection'
  'models/FiltersModel'
  'views/DonationsListView'
  'views/DonationFormView'
  'views/TeamMapView'
  'views/feed/EventsListView'
  'vex'
  'autolink'
], ($, _, Backbone, foundation, tabs, jade, Mixen, BaseView, ModelView, Donations, FeedEvents, Checkins, Filters, DonationsListView, DonationFormView, TeamMapView, EventsListView, vex, autolink) ->
  class TeamProfile extends Mixen(ModelView, BaseView)
    template: jade.team
    events:
      'click .team-avatar.avatar-large': 'openLargeAvatar'
      'click .donate-button': 'donate'

    initialize: (options) =>
      @listenTo @model, 'loaded', @loadChildData
      @listenTo @model, 'change error', @render

      super

    loadChildData: =>
      # can only be loaded after we determine the id for the team slug
      names = @model.get 'names'
      uni = @model.get 'university'
      document.title = "#{names} (#{uni}) | JailbreakHQ"
      @render()

      # Events
      feedFilters = new Filters
        teamId: @model.get 'id'
      storyEvents = new FeedEvents [],
        filters: feedFilters
      storyEvents.fetch()

      @eventsListView = new EventsListView
        collection: storyEvents
      @rememberView @eventsListView

      # Donations
      donationFilters = new Filters
        teamId: @model.get 'id'
      donations = new Donations [],
        filters: donationFilters
      donations.fetch()

      @donationsListView = new DonationsListView
        collection: donations
      @rememberView @donationsListView

      # Checkins
      @checkins = new Checkins [],
        teamId: @model.get 'id'
      @checkins.fetch()
      @listenTo @checkins, 'sync', @renderTeamMap

    render: =>
      @$el.html @template @getRenderContext()

      $(document).foundation() # tabs

      $('#donations-panel', @$el).html @donationsListView?.render().$el
      $('#team-story', @$el).append @eventsListView?.render().$el

      @

    renderTeamMap: =>
      require ['async!//maps.googleapis.com/maps/api/js?v=3.exp&sensor=false'], (data) =>
        checkinsMapView = new TeamMapView
          checkins: @checkins
          mapElement: 'team-map'
        checkinsMapView.renderMap()
        checkinsMapView.renderTeamMarkers()
        @rememberView checkinsMapView

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
      avatar.addEventListener 'load', displayVex
      avatar.src = @model.get 'avatarLarge'

    donate: (event) =>
      donationView = new DonationFormView
        teamId: @model.get 'id'
        name: @model.get 'names'
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
      vex.close @donateVexId
