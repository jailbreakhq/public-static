define [
  'mixen'
  'mixens/FilterableCollectionMixen'
  'mixens/TotalCountCollectionMixen'
  'mixens/BaseCollectionMixen'
  'models/DonationModel'
], (Mixen, FilterableCollection, TotalCountCollection, BaseCollection, Donation) ->
  class Donations extends Mixen(FilterableCollection, TotalCountCollection, BaseCollection)
    model: Donation
    urlPath: '/donations'