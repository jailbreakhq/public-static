define [
  'jquery'
  'underscore'
  'backbone'
  'mixen'
  'mixens/FilterableCollectionMixen'
  'mixens/BaseCollectionMixen'
  'models/TeamModel'
], ($, _, Backbone, Mixen, FilterableCollectionMixen, BaseCollectionMixen, Team) ->
  class Teams extends Mixen(FilterableCollectionMixen, BaseCollectionMixen)
    model: Team

    url: =>
      if @filters
        encodedFilters = encodeURIComponent JSON.stringify @filters
        url = '/teams?filters=' + encodedFilters
      else
        url = '/teams'

      super + url

    comparator: (item) ->
      item.get 'position'