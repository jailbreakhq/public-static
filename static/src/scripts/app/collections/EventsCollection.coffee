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
    urlPath: '/events'