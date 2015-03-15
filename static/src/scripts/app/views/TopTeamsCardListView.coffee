define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'mixen'
  'mixens/BaseViewMixen'
  'mixens/CollectionViewMixen'
  'views/TeamsCardView'
  'humanize'
], ($, _, Backbone, jade, Mixen, BaseView, CollectionView, TeamsCardView, Humanize) ->
  class TopTeamsCardListView extends Mixen(CollectionView, BaseView)
    template: jade.iframeLeaders

    render: =>
      context = @getRenderContext()
      $('#leaders').html @template context

      top = _.first @collection.models, 2
      _.each top, (team) ->
        teamCardView = new TeamsCardView
          model: team
        $('#leaders-list').append teamCardView.render().$el

      @
