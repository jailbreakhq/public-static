require [
  "jquery"
  "underscore"
  "backbone"
  "foundation"
  "foundation.topbar"
  "AppRouter"
], ($, _, Backbone, foundation, topbar, Router) ->
  
  $ ->
    $(document).foundation()

    # Backbone setup
    AppRouter = new Router()

    # Clean up after any previous runs
    window.location.hash = ''
    Backbone.history.stop()

    Backbone.history.start
      pushState: true

    $(document).on "click", "a[href^='/']", (event) ->

      href = $(event.currentTarget).attr("href")

      # Allow shift+click for new tabs, etc.
      if !event.altKey && !event.ctrlKey && !event.metaKey && !event.shiftKey
        event.preventDefault()

        # Remove leading slashes and hash bangs (backward compatablility)
        url = href.replace(/^\//,'').replace('\#\!\/','')

        # Instruct Backbone to trigger routing events
        AppRouter.navigate url, { trigger: true }

        return false
