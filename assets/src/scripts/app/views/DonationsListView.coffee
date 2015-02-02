define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "humanize"
  "collections/DonationsCollection"
], ($, _, Backbone, jade, Humanize, Donations) ->
  class DonationsList extends Backbone.View
    template: jade.teamDonations

    initialize: (options) =>
      @collection = new Donations [],
        filters:
          teamId: options.teamId
      @collection.fetch
        success: @render

    render: =>
      data =
        donations: _.map @collection.models, (val) -> val.toJSON()
      @$el.html @template data

      @