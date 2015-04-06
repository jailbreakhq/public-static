define [
  'mixen'
  'mixens/FilterableCollectionMixen'
  'mixens/BaseCollectionMixen'
  'models/TeamModel'
], (Mixen, FilterableCollectionMixen, BaseCollectionMixen, Team) ->
  class Teams extends Mixen(FilterableCollectionMixen, BaseCollectionMixen)
    model: Team
    urlPath: '/teams'