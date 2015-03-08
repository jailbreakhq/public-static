define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/BaseCollectionMixen"
  "models/CheckinModel"
], ($, _, Backbone, Mixen, BaseCollectionMixen, Checkin) ->
  class Checkins extends Mixen(BaseCollectionMixen)
    model: Checkin

    initialize: (data, options) =>
      @teamId = options.teamId

    url: =>
      super + "/teams/" + @teamId + "/checkins?limit=20"