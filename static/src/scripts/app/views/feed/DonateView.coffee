define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
], ($, _, Backbone, jade) ->
  class DonateView extends Backbone.View
    template: jade.feedDonate
    
    initialize: (options) =>
      console.log @model
      
      @listenTo @model, "change", @render

      super

    render: =>
      @$el.html @template @model.getRenderContext()
      @