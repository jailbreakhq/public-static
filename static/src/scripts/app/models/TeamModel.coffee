define [
  'jquery'
  'underscore'
  'backbone'
  'mixen'
  'mixens/BaseModelMixen'
  'models/CheckinModel'
], ($, _, Backbone, Mixen, BaseModelMixen, Checkin) ->
  class Team extends Mixen(BaseModelMixen)
    defaults:
      avatar: 'https://static.jailbreakhq.org/avatars/jb-default-avatar.jpg'

    initialize: (options) ->
      super

    url: =>
      if @get 'slug'
        jailbreak.api_host + '/teams/slug/' + @get 'slug'
      else
        jailbreak.api_host + '/teams/' + @get 'id'

    parse: (response) ->
      lastCheckin = response.lastCheckin
      if lastCheckin
        response.lastCheckin = new Checkin lastCheckin

      response

    getRenderContext: ->
      context = super ? {}

      context = _.extend context, @.toJSON()
      if @.has 'lastCheckin'
        context.lastCheckin = @.get('lastCheckin').toJSON()

      context
