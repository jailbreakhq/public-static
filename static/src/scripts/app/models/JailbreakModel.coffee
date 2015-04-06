define [
  'mixen'
  'mixens/BaseModelMixen'
], (Mixen, BaseModelMixen) ->
  class Jailbreak extends Mixen(BaseModelMixen)
    urlRoot: jailbreak.api_host + '/'
    defaults:
      amountRaised: 0

    initialize: (options) ->
      super