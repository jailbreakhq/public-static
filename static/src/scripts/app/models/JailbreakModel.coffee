define [
  'jquery'
  'underscore'
  'backbone'
  'mixen'
  'mixens/BaseModelMixen'
], ($, _, Backbone, Mixen, BaseModelMixen) ->
  class Jailbreak extends Mixen(BaseModelMixen)
    urlRoot: jailbreak.api_host + '/'
    defaults:
      amountRaised: 0

    initialize: (options) ->
      super