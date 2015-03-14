define [
  'jquery'
  'underscore'
  'backbone'
  'mixen'
  'mixens/FilterableCollectionMixen'
  'mixens/BaseCollectionMixen'
  'models/feed/EventModel'
], ($, _, Backbone, Mixen, FilterableCollectionMixen, BaseCollectionMixen, Event) ->
  class Events extends Mixen(FilterableCollectionMixen, BaseCollectionMixen)
    model: Event

    initialize: (data, options) ->
      super

    url: =>
      if @filters
        filtersJSON = encodeURIComponent JSON.stringify @filters
        url = "/events?limit=40&filters=#{filtersJSON}"
      else
        url = '/events?limit=40'
      super + url
