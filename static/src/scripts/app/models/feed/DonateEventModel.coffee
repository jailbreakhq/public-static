define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/BaseModelMixen"
], ($, _, Backbone, Mixen, BaseModelMixen) ->
  class DonateEvent extends Mixen(BaseModelMixen)

    initialize: (options) ->
      super

    url: ->
      jailbreak.api_host + "/events/donates"

    getRenderContext: ->
      @.toJSON()