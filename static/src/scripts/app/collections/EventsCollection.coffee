define [
  'mixen'
  'mixens/FilterableCollectionMixen'
  'mixens/BaseCollectionMixen'
  'models/feed/EventModel'
], (Mixen, FilterableCollection, BaseCollection, Event) ->
  class Events extends Mixen(FilterableCollection, BaseCollection)
    model: Event
    urlPath: '/events'