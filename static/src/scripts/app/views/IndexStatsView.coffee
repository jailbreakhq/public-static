define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "views/DonationFormView"
  "vex"
], ($, _, Backbone, jade, DonationFormView, vex) ->
  class TeamItem extends Backbone.View
    template: jade.indexStats
    events:
      "click .donate-button": "donate"
    
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
