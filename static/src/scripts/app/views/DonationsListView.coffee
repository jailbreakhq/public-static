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
      if not options.collection
        new Error("DonationsList view needs a collection in it's options")
      @collection = options.collection

    render: =>
      data =
        donations: _.map @collection.models, (val) -> val.toJSON()
      @$el.html @template data

      @