define [
  'jquery'
  'underscore'
  'backbone'
  'mixen'
  'models/TeamModel'
  'mixens/BaseModelMixen'
], ($, _, Backbone, Mixen, Team, BaseModelMixen) ->
  class Donation extends Mixen(BaseModelMixen)
    
    initialize: (options) ->
      super

    parse: (response) ->
      team = response.team
      if team
        response.team = new Team team

      response

    getRenderContext: =>
      context = @toJSON()
      if @.has 'team'
        context.team = @.get('team').toJSON()

      context
