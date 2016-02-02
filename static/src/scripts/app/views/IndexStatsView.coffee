define [
  'jquery'
  'underscore'
  'jade.templates'
  'mixen'
  'mixens/BaseViewMixen'
  'mixens/ModelViewMixen'
  'views/DonationFormView'
  'vex'
], ($, _, jade, Mixen, BaseView, ModelView, DonationFormView, vex) ->
  class IndexStats extends Mixen(ModelView, BaseView)
    template: jade.indexStats
    events:
      'click .donate-button': 'donate'

    render: =>
      loadingContext = @getRenderContext()

      percent = (((@model.get('amountRaised') / 100) / 100000) * 100) or 0
      percentWidth = if (percent > 100) then 100 else percent

      context =
        percentageWidth: percentWidth
        percentage: percent
      _.extend context, loadingContext
      _.extend context, @model.toJSON()

      @$el.html @template context
      @

    donate: (event) =>
      donationView = new DonationFormView
        parent: @

      vex.defaultOptions.className = 'vex-theme-default'
      $vexContent = vex.open
        content: donationView.render().$el
        contentClassName: 'narrow padding-less'
        overlayClosesOnClick: false
        afterOpen: ($vexContent) ->
          $vexContent.append.$el

      @donateVexId = $vexContent.data().vex.id

    closeDonateVex: =>
      vex.close(@donateVexId)
