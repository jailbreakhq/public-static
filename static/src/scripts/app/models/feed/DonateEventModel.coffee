define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/BaseModelMixen"
  "models/TeamModel"
], ($, _, Backbone, Mixen, BaseModelMixen, Team) ->
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

    parse: (response) ->
      team = response.team
      if team
        response.team = new Team team

      response