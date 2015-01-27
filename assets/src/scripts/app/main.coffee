define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
], ($, _, Backbone, jade) ->
  
  $ ->

    class AppView extends Backbone.View
      el_tag = "#body-container"
      el: $(el_tag)

      template: jade.test

      initialize: =>
        @render()

      render: =>
        # data = @template({name: "kevin"})
        # console.log data
        $("#body-container").html(@template({name: "kevin"}))

    $(document).foundation();
    app = new AppView()
