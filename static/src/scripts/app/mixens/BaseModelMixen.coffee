define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/AuthMixen"
  "mixens/LoadedMixen"
], ($, _, backbone, Mixen, AuthMixen, LoadedMixen) ->
  class BaseModel extends Mixen(LoadedMixen, AuthMixen, Backbone.Model)
    urlRoot: jailbreak.api_host

    initialize: ->
      super # necessary to not break chain