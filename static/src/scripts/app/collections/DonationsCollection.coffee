define [
  'jquery'
  'underscore'
  'backbone'
  'mixen'
  'mixens/FilterableCollectionMixen'
  'mixens/TotalCountCollectionMixen'
  'mixens/BaseCollectionMixen'
  'models/DonationModel'
], ($, _, Backbone, Mixen, FilterableCollection, TotalCountCollection, BaseCollection, Donation) ->
  class Donations extends Mixen(FilterableCollection, TotalCountCollection, BaseCollection)
    model: Donation

    url: =>
      if @filters
        encodedFilters = encodeURIComponent JSON.stringify @filters
        url = "/donations?filters=#{encodedFilters}"
      else
        url = '/donations'

      super + url