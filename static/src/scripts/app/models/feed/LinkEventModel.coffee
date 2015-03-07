define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/BaseModelMixen"
], ($, _, Backbone, Mixen, BaseModelMixen) ->
  class Link extends Mixen(BaseModelMixen)

    initialize: (options) ->
      super

    url: ->
      jailbreak.api_host + "/events/links"

    getRenderContext: ->
      @.toJSON()