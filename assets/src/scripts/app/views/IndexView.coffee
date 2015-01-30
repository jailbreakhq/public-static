define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "foundation"
  "views/TeamListView"
], ($, _, Backbone, jade, foundation, TeamListView) ->
  class Index extends Backbone.View
    el_tag = "#body-container"
    el: $(el_tag)

    template: jade.main

    initialize: =>
      @teamListview = new TeamListView()
      @render()

    render: =>
      $("#body-container").html(@template())

      @$el.append(@teamListview.render().$el)
      @
