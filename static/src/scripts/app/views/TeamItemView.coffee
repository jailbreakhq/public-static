define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
], ($, _, Backbone, jade) ->
  class TeamItem extends Backbone.View
    tagName: "li"
    className: "team"
    template: jade.teamListItem
    
    initialize: (options) =>
      if options.template
        @template = options.template
      if options.tagName
        @tagName = options.tagName
      @model.bind "change", @render

      super

    render: =>
      @$el.html @template @model.getRenderContext()
      @
