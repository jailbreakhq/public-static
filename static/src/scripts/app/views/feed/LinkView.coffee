define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
], ($, _, Backbone, jade) ->
  class LinkView extends Backbone.View
    template: jade.feedLink
    
    initialize: (options) =>
      @listenTo @model, 'change', @render

      super

    render: =>
      @$el.html @template @model.getRenderContext()
      @