define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/BaseModelMixen"
  "models/TeamModel"
], ($, _, Backbone, Mixen, BaseModelMixen, Team) ->
  class Link extends Mixen(BaseModelMixen)

    initialize: (options) ->
      super

    url: ->
      jailbreak.api_host + "/events/links"

    getRenderContext: ->
      @.toJSON()