define [
  'jquery'
  'underscore'
  'backbone'
  'mixen'
  'mixens/FilterableCollectionMixen'
  'mixens/BaseCollectionMixen'
  'models/feed/EventModel'
], ($, _, Backbone, Mixen, FilterableCollection, BaseCollection, Event) ->
  class Events extends Mixen(FilterableCollection, BaseCollection)
    model: Event

    url: =>
      if @filters
        filtersJSON = encodeURIComponent JSON.stringify @filters
        url = "/events?limit=15&filters=#{filtersJSON}"
      else
        url = '/events?limit=15'
      super + url
