define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'ladda'
  'foundation'
  'foundation.alert'
  'foundation.tooltip'
  'jquery.payment'
  'animo'
], ($, _, Backbone, jade, Ladda, foundation) ->
  class DonationFormView extends Backbone.View
    template: jade.donationForm
    events:
      'click #donate-submit': 'donateSubmissionHandler'

    initialize: (options) =>
      @name = options?.name or 'JailbreakHQ'
      @teamId = options?.teamId or 0
      @parentView = options?.parent
      @iphoneRedirect = options?.iphoneRedirect or false
      @submitted = false

    render: =>
      data =
        name: @name

      @$el.html @template data

      $(@$el).foundation('tooltip', 'reflow')

      # add stripe's jquery.payment input field restrictions (super cool)
      $('.cc-num', @$el).payment('formatCardNumber')
      $('.cc-exp', @$el).payment('formatCardExpiry')
      $('.cc-cvc', @$el).payment('formatCardCVC')
      $('[data-numeric]', @$el).payment('restrictNumeric')

      @

    donateFormResponse: (type, messages) =>
      $('#stripe-responses').html jade.alert {type: type, messages: messages}
      $(@$el).foundation('alert', 'reflow')
      @l?.stop()

    clearDonateFormResponse: ->
      $('#stripe-responses').empty()

    validateEmail: (email) ->
      re = /\S+@\S+\.\S+/
      return re.test email

    donateSubmissionHandler: (event) =>
      # prevent action and disable button
      event.preventDefault()
      @l = Ladda.create document.querySelector '#donate-submit'
      @l.start()

      # extract form fields
      number = $('.cc-num', @$el).val()
      exp = $('.cc-exp', @$el).val()
      cvc = parseInt $('.cc-cvc', @$el).val().trim()
      amount = parseInt $('.cc-amount', @$el).val()
      name = $('.cc-name', @$el).val()
      email = $('.cc-email', @$el).val()

      exp_month = parseInt exp.split('/')[0]?.trim()
      exp_year = parseInt exp.split('/')[1]?.trim()

      # do some form validation
      errors = []

      valid = true
      if not @validateEmail email
        errors.push('Please provide an email address')
        $('.cc-email', @$el).addClass('error-field')
        valid = false
      else
        $('.cc-email', @$el).removeClass('error-field')

      if not $.payment.validateCardNumber(number)
        errors.push('Check your card number')
        $('.cc-num', @$el).addClass('error-field')
        valid = false
      else
        $('.cc-num', @$el).removeClass('error-field')

      if not $.payment.validateCardExpiry(exp_month, exp_year)
        errors.push('Check your card expiry')
        $('.cc-exp', @$el).addClass('error-field')
        valid = false
      else
        $('.cc-exp', @$el).removeClass('error-field')

      if not $.payment.validateCardCVC(cvc)
        errors.push('Check the CVC number is on the back of your card')
        $('.cc-cvc', @$el).addClass('error-field')
        valid = false
      else
        $('.cc-cvc', @$el).removeClass('error-field')

      if not (amount >= 5)
        errors.push('Minimum donation 5 euro')
        $('.cc-amount', @$el).addClass('error-field')
        valid = false
      else
        $('.cc-amount', @$el).removeClass('error-field')


      if not valid
        @donateFormResponse('alert', errors)
        $('#donate-form .content').animo
          animation: 'shake-subtle'
          duration: 0.5
        @l.stop()
        return false
      else
        @clearDonateFormResponse()

      @l.setProgress 0.4

      # bundle up the stripe token
      number = parseInt number.replace /\s/g, '' # remove any space in card number
      stripeData =
        number: number
        cvc: cvc
        exp_month: exp_month
        exp_year: exp_year
        name: name

      formData =
        email: email
        amount: amount
        backer: $('#list-me').prop('checked')

      @data = _.extend stripeData, formData

      if not @submitted # ensure each view can only send one donation charge request
        @submitted = true
        Stripe.card.createToken stripeData, @stripeResponseHandler

    stripeResponseHandler: (status, response) =>
      @l.setProgress 0.7

      if response.error
        @donateFormResponse('alert', [response.error.message])
      else
        attributes =
          amount: @data.amount * 100
          token: response.id
          email: @data.email
          name: @data.name
          teamId: @teamId
          backer: @data.backer

        $.ajax(
          type: 'POST'
          url: jailbreak.api_host + '/stripe'
          dataType: 'json'
          contentType: 'application/json'
          data: JSON.stringify(attributes)
        ).done (data) =>
          @l.setProgress 1.0
          if @iphoneRedirect
            window.location = 'jailbreak://'
          else
            @donationThankYou()
        .fail (err) =>
          @submitted = false
          if err.status == 500
            @donateFormResponse('alert', ['We\'re suffering some technical difficulties please try again later today'])
          else
            @donateFormResponse('alert', ['Donation failed: ' + err.responseJSON.message])

    donationThankYou: =>
      $('#donate-content').slideUp 300, =>
        $('section.content').append jade.donationThankYou()
        $('#donate-thank-you').slideDown 300
        $('#donate-close').click () =>
          if @parentView
            @parentView.closeDonateVex()
          else
            window.location = 'https://jailbreakhq.org'
