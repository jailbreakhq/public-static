define [
  'mixen'
  'mixens/FilterableCollectionMixen'
  'mixens/BaseCollectionMixen'
  'mixens/TotalCountCollectionMixen'
  'mixens/PaginatableCollectionMixen'
  'models/TeamModel'
], (Mixen, FilterableCollectionMixen, BaseCollectionMixen, TotalCountCollection, PaginatableCollection, Team) ->
  class Teams extends Mixen(PaginatableCollection, FilterableCollectionMixen, TotalCountCollection, BaseCollectionMixen)
    model: Team
    urlPath: '/teams'

    initialize: (models, options) ->
      super

      if options?.urlPath
        @urlPath = options.urlPath