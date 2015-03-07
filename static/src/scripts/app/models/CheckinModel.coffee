define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/BaseModelMixen"
], ($, _, Backbone, Mixen, BaseModelMixen) ->
  class Checkin extends Mixen(BaseModelMixen)

    initialize: (options) ->
      @teamId = options.teamId

      super

    url: ->
      jailbreak.api_host + "/teams/" + @teamId + "/checkins"
