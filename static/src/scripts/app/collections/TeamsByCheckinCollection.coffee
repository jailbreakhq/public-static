define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/FilterableCollectionMixen"
  "mixens/BaseCollectionMixen"
  "models/TeamModel"
], ($, _, Backbone, Mixen, FilterableCollectionMixen, BaseCollectionMixen, Team) ->
  class TeamsByCheckin extends Mixen(FilterableCollectionMixen, BaseCollectionMixen)
    model: Team

    url: ->
      url = "/teams/lastcheckin"

      super + url

    comparator: (item) ->
      return item.get('lastCheckin')?.get('time')