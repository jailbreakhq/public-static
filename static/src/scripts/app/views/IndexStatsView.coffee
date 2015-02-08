define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
], ($, _, Backbone, jade) ->
  class TeamItem extends Backbone.View
    template: jade.indexStats
    
    initialize: =>
      @model.bind "change", @render

    render: =>
      percent = (((@model.get('amountRaised') / 100) / 100000) * 100) or 0
      percentWidth = if (percent > 100) then 100 else percent

      data =
        percentageWidth: percentWidth
        percentage: percent
      _.extend data, @model.toJSON()

      @$el.html @template data
      @
