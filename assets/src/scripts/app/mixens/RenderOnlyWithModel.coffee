define [
],  ->
  class RenderOnlyWithModel
    render: ->
      return unless @model

      super