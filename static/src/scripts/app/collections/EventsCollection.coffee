define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/BaseCollectionMixen"
  "models/feed/EventModel"
], ($, _, Backbone, Mixen, BaseCollectionMixen, Event) ->
  class Events extends Mixen(BaseCollectionMixen)
    model: Event

    initialize: (options) ->
      super

    url: =>
      url = "/events"
      super + url
