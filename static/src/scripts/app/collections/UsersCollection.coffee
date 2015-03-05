define [
  "jquery"
  "underscore"
  "backbone"
  "mixen"
  "mixens/BaseCollectionMixen"
  "models/UserModel"
], ($, _, Backbone, Mixen, BaseCollectionMixen, User) ->
  class Users extends Mixen(BaseCollectionMixen)
    model: User

    url: =>
      url = "/users"

      super + url
