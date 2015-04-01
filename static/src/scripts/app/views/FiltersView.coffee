define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'drop'
], ($, _, Backbone, jade, Drop) ->
  class FiltersView extends Backbone.View

    initialize: (options) =>
      @collection = options.collection
      @filters = options.filters

    render: =>
      @

    open: (event) ->
      console.log event
      drop = new Drop
        element: event.target
        target: document.querySelector '.drop-target'
        content: 'Something awesome cool!' #jade.filters()
        position: 'bottom center'
        openOn: 'click'