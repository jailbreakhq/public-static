define [
  'mixen'
  'mixens/BaseCollectionMixen'
  'models/CheckinModel'
], (Mixen, BaseCollectionMixen, Checkin) ->
  class Checkins extends Mixen(BaseCollectionMixen)
    model: Checkin

    initialize: (data, options) =>
      @teamId = options.teamId

      super

    url: =>
      jailbreak.api_host + "/teams/#{@teamId}/checkins?limit=20"