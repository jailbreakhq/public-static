define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "views/admin/AddCheckinFormView"
  "vex"
], ($, _, Backbone, jade, AddCheckinView, vex) ->
  class TeamItem extends Backbone.View
    tagName: "li"
    className: "team"
    template: jade.teamListItem
    events:
      "click .add-checkin": "addCheckin"
    
    initialize: (options) =>
      if options.template
        @template = options.template

      if options.tagName
        @tagName = options.tagName

      @model.bind "change sync", @render

      super

    render: =>
      @$el.html @template @model.getRenderContext()
      @

    addCheckin: (event) ->
      addCheckinView = new AddCheckinView
        team: @model
        parent: @

      vex.defaultOptions.className = 'vex-theme-default'
      $vexContent = vex.open
        content: addCheckinView.render().$el
        afterOpen: ($vexContent) ->
          $vexContent.append.$el

      @vexId = $vexContent.data().vex.id

    closeVex: =>
      vex.close @vexId