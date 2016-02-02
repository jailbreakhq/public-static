define [
  'mixen'
  'mixens/BaseModelMixen'
  'models/CheckinModel'
], (Mixen, BaseModelMixen, Checkin) ->
  class Team extends Mixen(BaseModelMixen)
    defaults:
      avatar: 'https://static.jailbreakhq.org/avatars/jb-default-avatar.jpg'

    initialize: (options) ->
      super

    url: =>
      if @get 'slug'
        jailbreak.api_host + '/teams/' + @get 'slug'
      else
        jailbreak.api_host + '/teams/' + @get 'id'

    parse: (response) ->
      lastCheckin = response.lastCheckin
      if lastCheckin
        response.lastCheckin = new Checkin lastCheckin

      response

    getRenderContext: ->
      context = @.toJSON()
      if @.has 'lastCheckin'
        context.lastCheckin = @.get('lastCheckin').toJSON()

      context
