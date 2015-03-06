define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
], ($, _, Backbone, Mixen) ->
  class Checkin extends Mixen(Backbone.Model)

    initialize: (options) ->
      @teamId = options.teamId

    url: ->
      jailbreak.api_host + "/teams/" + @teamId + "/checkins"
