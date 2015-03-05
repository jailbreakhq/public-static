define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
], ($, _, Backbone, jade) ->
  class Error extends Backbone.View
    template: jade.login
    events:
      "submit #login-form": "login"
      "click #submit-login": "login"

    initialize: ->
      $('#body-container').addClass('login')

    render: =>
      @$el.html @template()

      @

    login: (event) ->
      console.log event