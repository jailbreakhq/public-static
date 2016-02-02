define [
  'mixen'
  'mixens/BaseModelMixen'
  'models/TeamModel'
], (Mixen, BaseModelMixen, Team) ->
  class Link extends Mixen(BaseModelMixen)

    initialize: (options) ->
      super

    url: ->
      jailbreak.api_host + '/events/links'

    getRenderContext: ->
      @.toJSON()