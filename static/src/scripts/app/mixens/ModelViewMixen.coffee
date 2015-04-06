define [
  'underscore'
], (_) ->
  class ModelView

    initialize: (options) ->
      @listenTo @model, 'loading loaded error', =>
        @render()

    getRenderContext: ->
      context = super ? {}

      sync =
        error: @model.error
        errorMessage: @model.errorMessage
        errorStatus: @model.errorStatus
        loading: @model.syncing

      model = @model.toJSON()

      _.extend context, sync
      _.extend context, model

      context