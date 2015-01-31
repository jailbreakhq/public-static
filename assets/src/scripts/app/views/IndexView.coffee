define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "foundation"
  "views/TeamListView"
], ($, _, Backbone, jade, foundation, TeamListView) ->
  class Index extends Backbone.View
    template: jade.main

    initialize: =>
      @teamListview = new TeamListView()
      @render()

    render: =>
      @$el.append @teamListview.render().$el
      @
