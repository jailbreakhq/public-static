define [
  'jquery'
  'underscore'
  'backbone'
  'jade.templates'
  'ladda'
  'foundation.alert'
  'animo'
], ($, _, Backbone, jade, Ladda) ->
  class LoginView extends Backbone.View
    template: jade.login
    events:
      'click #submit-login': 'login'

    initialize: ->
      $('#body-container').addClass('login')

    render: =>
      @$el.html @template()

      @

    login: (event) =>
      event.preventDefault()

      @l = Ladda.create document.querySelector '#submit-login'
      @l.start()

      data =
        email: $('#input-email').val()
        password: $('#input-password').val()

      valid = true
      if not data.email
        $('#input-email').addClass 'error-field'
        valid = false
      else
        $('#input-email').removeClass 'error-field'

      if not data.password
        $('#input-password').addClass 'error-field'
        valid = false
      else
        $('#input-password').removeClass 'error-field'

      if not valid
        $('#login-form').animo
          animation: 'shake-subtle'
          duration: 0.5
        @l.stop()
        return false

      $.ajax(
        url: jailbreak.api_host + '/authenticate/login'
        data: JSON.stringify(data)
        type: 'POST'
        contentType: 'application/json'
        dataType: 'json'
      ).done((data, status) ->
        localStorage.setItem 'apiToken', JSON.stringify(data)
        Backbone.history.navigate 'admin', true
      ).fail( ->
        $('#login-form').animo
          animation: 'shake-subtle'
          duration: 0.5
      ).always( =>
        @l.stop()
      )