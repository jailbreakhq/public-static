define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "collections/DonationsCollection"
], ($, _, Backbone, jade, Donations) ->
  class DonationsList extends Backbone.View
    template: jade.teamDonations

    initialize: (options) =>
      @collection = new Donations
        filters:
          teamId: options.teamId
      @collection.fetch
        success: @render

    render: =>
      data =
        donations: _.map @collection.models, (val) -> val.toJSON()
      console.log data
      @$el.html @template data

      @