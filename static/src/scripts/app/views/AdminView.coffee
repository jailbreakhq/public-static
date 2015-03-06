define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "mixen"
  "mixens/RequiresLoginMixen"
], ($, _, Backbone, jade, Mixen, RequiresLoginMixen) ->
  class LoginView extends Mixen(RequiresLoginMixen, Backbone.View)
    template: jade.admin

    render: =>
      super
      
      @$el.html @template()

      @