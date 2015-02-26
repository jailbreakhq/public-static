define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/FilterableCollectionMixen"
  "mixens/BaseCollectionMixen"
  "models/DonationModel"
], ($, _, Backbone, Mixen, FilterableCollectionMixen, BaseCollectionMixen, Donation) ->
  class Donations extends Mixen(FilterableCollectionMixen, BaseCollectionMixen)
    model: Donation

    initialize: (data, options) ->
      super

    url: =>
      if @filters
        encodedFilters = encodeURIComponent JSON.stringify @filters
        url = "/donations?filters=" + encodedFilters
      else
        url = "/donations"

      super + url