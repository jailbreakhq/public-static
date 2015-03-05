define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
], ($, _, Backbone, jade) ->
  class LoginView extends Backbone.View
    template: jade.admin

    initialize: (options) ->
      #

    render: =>
      @$el.html @template()

      @