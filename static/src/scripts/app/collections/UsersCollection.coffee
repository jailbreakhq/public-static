define [
  'jquery'
  'underscore'
  'backbone'
  'mixen'
  'mixens/BaseCollectionMixen'
  'models/UserModel'
], ($, _, Backbone, Mixen, BaseCollectionMixen, User) ->
  class Users extends Mixen(BaseCollectionMixen)
    model: User

    initialize: (options) ->
      super

    url: =>
      url = '/users'
      super + url
