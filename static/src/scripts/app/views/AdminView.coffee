define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "collections/UsersCollection"
], ($, _, Backbone, jade, Users) ->
  class LoginView extends Backbone.View
    template: jade.admin

    initialize: (options) ->
      # users = new Users
      # users.fetch()

    render: =>
      @$el.html @template()

      @