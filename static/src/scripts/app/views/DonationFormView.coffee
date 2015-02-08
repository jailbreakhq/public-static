define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "jquery.payment"
], ($, _, Backbone, jade, payment) ->
  class DonationFormView extends Backbone.View
    template: jade.donationForm
    events:
      'submit #donate-form': 'donateSubmissionHandler'

    initialize: (options) =>
      if options.name
        @name = options.name
      else
        @name = "JailbreakHQ"

    render: =>
      data =
        name: "JailbreakHQ"

      @$el.html @template data

      # add stripe's jquery.payment input field restrictions (super cool)
      $(".cc-num", @$el).payment("formatCardNumber")
      $(".cc-exp", @$el).payment("formatCardExpiry")
      $(".cc-cvc", @$el).payment("formatCardCVC")
      $("[data-numeric]", @$el).payment("restrictNumeric")

      @

    donateSubmissionHandler: (event) ->
      event.preventDefault()

      number = $("#stripe-number").val()
      cvc = $("#stripe-cvc").val()
      exp_month = $("#stripe-exp-month").val()
      exp_year = $("#stripe-exp-year").val()
      name = $("#stripe-name").val()

      console.log $.payment.validateCardNumber(number)

      stripeData =
        number: number
        cvc: cvc
        exp_month:exp_month
        exp_year: exp_year
        name: name

      formData =
        email: $("#stripe-email").val()
        amount: $("#stripe-amount").val()

      console.log stripeData
      console.log formData

      #Stripe.card.createToken data, stripeResponseHandler

    stripeResponseHandler: (status, response) ->
      console.log status
      console.log response