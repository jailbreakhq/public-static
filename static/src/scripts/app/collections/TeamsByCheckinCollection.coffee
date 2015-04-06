define [
  'mixen'
  'mixens/FilterableCollectionMixen'
  'mixens/BaseCollectionMixen'
  'models/TeamModel'
], (Mixen, FilterableCollectionMixen, BaseCollectionMixen, Team) ->
  class TeamsByCheckin extends Mixen(FilterableCollectionMixen, BaseCollectionMixen)
    model: Team
    urlPath: '/teams/lastcheckin'

    comparator: (item) ->
      return item.get('lastCheckin')?.get('time')