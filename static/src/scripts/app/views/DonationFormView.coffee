define [
  "jquery"
  "underscore"
  "backbone"
  "jade.templates"
  "ladda"
  "foundation"
  "foundation.alert"
  "jquery.payment"
  "animo"
], ($, _, Backbone, jade, Ladda, foundation) ->
  class DonationFormView extends Backbone.View
    template: jade.donationForm
    events:
      'submit #donate-form': 'donateSubmissionHandler'
      'click #donate-submit': 'donateSubmissionHandler'

    initialize: (options) =>
      if options.name
        @name = options.name
      else
        @name = "JailbreakHQ"

    render: =>
      data =
        name: @name

      @$el.html @template data

      # add stripe's jquery.payment input field restrictions (super cool)
      $(".cc-num", @$el).payment("formatCardNumber")
      $(".cc-exp", @$el).payment("formatCardExpiry")
      $(".cc-cvc", @$el).payment("formatCardCVC")
      $("[data-numeric]", @$el).payment("restrictNumeric")

      $(@$el).foundation("alert", "reflow")

      @

    donateSubmissionHandler: (event) =>
      # prevent action and disable button
      event.preventDefault()
      @l = Ladda.create document.querySelector "#donate-submit"
      @l.start()

      # extract form fields
      number = $(".cc-num", @$el).val()
      exp = $(".cc-exp", @$el).val()
      cvc = parseInt $(".cc-cvc", @$el).val()
      amount = parseInt $(".cc-amount", @$el).val()
      name = $(".cc-name", @$el).val()
      email = $(".cc-email", @$el).val()

      exp_month = parseInt exp.split("/")[0].trim()
      exp_year = parseInt exp.split("/")[1].trim()

      # do some form validation
      valid = true
      if not $.payment.validateCardNumber(number)
        $(".cc-num", @$el).addClass("error-field")
        valid = false

      if not $.payment.validateCardExpiry(exp_month, exp_year)
        $(".cc-exp", @$el).addClass("error-field")
        valid = false

      if not $.payment.validateCardCVC(cvc, $.payment.cardType(number))
        $(".cc-cvc", @$el).addClass("error-field")
        valid = false

      if not amount > 0
        $(".cc-amount", @$el).addClass("error-field")
        valid = false

      if not valid
        $("#donate-form .content").animo
          animation: "shake-subtle"
          duration: 0.5
        @l.stop()
        return false

      $(".cc-num", @$el).removeClass("error-field")
      $(".cc-exp", @$el).removeClass("error-field")
      $(".cc-cvc", @$el).removeClass("error-field")

      @l.setProgress 0.4

      # bundle up the stripe token
      number = parseInt number.replace /\s/g, ''
      stripeData =
        number: number
        cvc: cvc
        exp_month: exp_month
        exp_year: exp_year
        name: name

      formData =
        email: email
        amount: amount

      console.log stripeData
      console.log formData

      Stripe.card.createToken stripeData, @stripeResponseHandler

    stripeResponseHandler: (status, response) =>
      @l.setProgress 0.8
      console.log status
      console.log response

      if response.error
        errors = $("#stripe-errors")
        errors.find("span").text response.error.message
        errors.removeClass("hide")
        @l.stop()
      else
        @l.stop()
