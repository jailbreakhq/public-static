define [
  'jquery'
  'underscore'
  'backbone'
  'mixen'
  'mixens/BaseModelMixen'
], ($, _, Backbone, Mixen, BaseModelMixen) ->
  class User extends Mixen(BaseModelMixen)
    # spooky

    initialize: (options) ->
      super