define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "models/TeamModel"
], ($, _, Backbone, Mixen, Team) ->
  class Donation extends Mixen(Backbone.Model)
    
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
