define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/BaseModelMixen"
], ($, _, Backbone, Mixen, BaseModelMixen) ->
  class DonateEvent extends Mixen(BaseModelMixen)
    defaults:
      linkText: "Donate"

    initialize: (options) ->
      super

    url: ->
      jailbreak.api_host + "/events/donates"

    getRenderContext: ->
      donate = @.toJSON()
      if @.has('team')
        donate.team = @.get('team').toJSON()

      donate