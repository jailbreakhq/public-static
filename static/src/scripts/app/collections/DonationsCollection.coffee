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
    urlPath: '/donations'