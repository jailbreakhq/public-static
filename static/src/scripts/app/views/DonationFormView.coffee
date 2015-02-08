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
      @name = options.name or "JailbreakHQ"
      @teamId = options.teamId or null
      @parentView = options.parent

    render: =>
      data =
        name: @name

      @$el.html @template data

      # add stripe's jquery.payment input field restrictions (super cool)
      $(".cc-num", @$el).payment("formatCardNumber")
      $(".cc-exp", @$el).payment("formatCardExpiry")
      $(".cc-cvc", @$el).payment("formatCardCVC")
      $("[data-numeric]", @$el).payment("restrictNumeric")

      @

    donateFormResponse: (type, message) =>
      $("#stripe-responses").append jade.alert {type: type, message: message}
      $(@$el).foundation("alert", "reflow")
      @l?.stop()

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
      else
        $(".cc-num", @$el).removeClass("error-field")

      if not $.payment.validateCardExpiry(exp_month, exp_year)
        $(".cc-exp", @$el).addClass("error-field")
        valid = false
      else
        $(".cc-exp", @$el).removeClass("error-field")

      if not $.payment.validateCardCVC(cvc, $.payment.cardType(number))
        $(".cc-cvc", @$el).addClass("error-field")
        valid = false
      else
        $(".cc-cvc", @$el).removeClass("error-field")

      if not amount > 0
        $(".cc-amount", @$el).addClass("error-field")
        valid = false
      else
        $(".cc-amount", @$el).removeClass("error-field")

      if not valid
        $("#donate-form .content").animo
          animation: "shake-subtle"
          duration: 0.5
        @l.stop()
        return false

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

      @data = _.extend stripeData, formData

      Stripe.card.createToken stripeData, @stripeResponseHandler

    stripeResponseHandler: (status, response) =>
      @l.setProgress 0.7

      if response.error
        @donateFormResponse("alert", response.error.message)
      else
        attributes =
          amount: @data.amount * 100
          token: response.id
          email: @data.email
          name: @data.name
          teamId: @teamId

        $.ajax(
          type: "POST"
          url: jailbreak.api_host + "/stripe"
          dataType: "json"
          contentType: "application/json"
          data: JSON.stringify(attributes)
        ).done (data) =>
          $("#donate-content").animo
            animation: "fadeOutUp"
            duration: 0.5
            keep: true
            , =>
              $("#donate-content").slideUp()
              $("section.content").append jade.donationThankYou()
              $("#donate-close").click () =>
                @parentView.closeDonateVex()

          #@parent.closeDonateVex()
        .fail (err) =>
          @donateFormResponse("alert", "Donation failed. Try again.")
