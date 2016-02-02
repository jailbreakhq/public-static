define [
  'mixen'
  'mixens/BaseCollectionMixen'
  'models/UserModel'
], (Mixen, BaseCollectionMixen, User) ->
  class Users extends Mixen(BaseCollectionMixen)
    model: User
    urlPath: '/users'