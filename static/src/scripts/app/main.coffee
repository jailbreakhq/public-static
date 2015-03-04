require [
  "jquery"
  "underscore"
  "backbone"
  "foundation"
  "foundation.topbar"
  "raven"
  "AppRouter"
  "signet"
], ($, _, Backbone, foundation, topbar, Raven, Router) ->
  
  $ ->
    # Config Sentry Raven Client
    if jailbreak.sentry.enabled
      Raven.config(jailbreak.sentry.dsn, {
        whitelistUrls: ['local.jailbreakhq.org', 'builds.jailbreakhq.org']
      }).install();

    # Sentry Foundation javascript events/handlers
    $(document).foundation()

    # Backbone setup
    AppRouter = new Router()

    # Clean up after any previous runs
    window.location.hash = ''
    Backbone.history.stop()

    Backbone.history.start
      pushState: true

    # hook all links on the page
    $(document).on "click", "a[href^='/']", (event) ->

      href = $(event.currentTarget).attr("href")

      # Allow shift+click for new tabs, etc.
      if !event.altKey && !event.ctrlKey && !event.metaKey && !event.shiftKey
        event.preventDefault()

        # Remove leading slashes and hash bangs (backward compatablility)
        url = href.replace(/^\//, "").replace("\#\!\/", "")

        # Instruct Backbone to trigger routing events
        AppRouter.navigate url, { trigger: true }

        return false
