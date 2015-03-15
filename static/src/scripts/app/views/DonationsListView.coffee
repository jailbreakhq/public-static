define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'mixen'
  'mixens/CollectionViewMixen'
  'humanize'
  'collections/DonationsCollection'
], ($, _, Backbone, jade, Mixen, CollectionViewMixen, Humanize, Donations) ->
  class DonationsList extends Mixen(CollectionViewMixen, Backbone.View)
    template: jade.teamDonations

    initialize: (options) ->
      if options.template
        @template = options.template

      super

    render: =>
      context = @getRenderContext()
      models =
        donations: _.map @collection.models, (val) -> val.getRenderContext()
        totalCount: @collection.totalCount

      context = _.extend context, models

      @$el.html @template context

      @