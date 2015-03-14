define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'humanize'
  'collections/DonationsCollection'
], ($, _, Backbone, jade, Humanize, Donations) ->
  class DonationsList extends Backbone.View
    template: jade.teamDonations

    initialize: (options) =>
      if not options.collection
        new Error('DonationsList view needs a collection in it\'s options')
      @collection = options.collection

      @listenTo @collection, 'sync', @render

      if options.template
        @template = options.template

    render: =>
      data =
        donations: _.map @collection.models, (val) -> val.getRenderContext()
        totalCount: @collection.totalCount
      @$el.html @template data

      @