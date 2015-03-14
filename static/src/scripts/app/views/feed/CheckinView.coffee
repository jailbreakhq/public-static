define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
], ($, _, Backbone, jade) ->
  class CheckinView extends Backbone.View
    template: jade.feedCheckin
    
    initialize: (options) =>
      @listenTo @model, 'change', @render

      super

    render: =>
      @$el.html @template @model.getRenderContext()
      @