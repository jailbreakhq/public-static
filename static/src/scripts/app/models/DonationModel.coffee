define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "models/TeamModel"
  "mixens/BaseModelMixen"
], ($, _, Backbone, Mixen, Team, BaseModelMixen) ->
  class Checkin extends Mixen(BaseModelMixen)
    
    initialize: (options) ->
      super

    parse: (response) ->
      team = response.team
      if team
        response.team = new Team team

      response

    getRenderContext: =>
      donation = @.toJSON()
      if @.has('team')
        donation.team = @.get('team').toJSON()

      donation
