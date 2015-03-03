define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
], ($, _, Backbone, Mixen) ->
  class Checkin extends Mixen(Backbone.Model)
    url: ->
      jailbreak.api_host + "/checkins"
