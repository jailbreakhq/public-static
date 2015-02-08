define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
], ($, _, Backbone, jade) ->
  class DonationFormView extends Backbone.View
    template: jade.donationForm
    events:
      'submit #donateForm': 'donateSubmissionHandler'

    initialize: (options) =>
      if options.name
        @name = options.name
      else
        @name = "JailbreakHQ"

    render: =>
      data =
        name: "JailbreakHQ"

      @$el.html @template data
      @

    donateSubmissionHandler: (event) ->
      stripeData =
        number: $("#stripe-number").val()
        cvc: $("#stripe-cvc").val()
        exp_month: $("#stripe-exp-month").val()
        exp_year: $("#stripe-exp-year").val()
        name: $("#stripe-name").val()

      formData =
        email: $("#stripe-email").val()
        amount: $("#stripe-amount").val()

      console.log stripeData
      console.log formData

      #Stripe.card.createToken data, stripeResponseHandler

    stripeResponseHandler: (status, response) ->
      console.log status
      console.log response