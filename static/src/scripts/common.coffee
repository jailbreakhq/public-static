requirejs.config
  baseUrl: "/build/scripts/app"
  paths:
    "jquery": "../../../components/jquery/dist/jquery",
    "underscore": "../../../components/underscore/underscore"
    "backbone": "../../../components/backbone/backbone"
    "moment": "../../../components/moment/moment"
    "humanize": "../../../components/humanize-plus/public/dist/humanize.min"
    "jade": "../../../components/jade/runtime"
    "mixen": "../../../components/mixen/mixen.min"
    "vex": "../../../components/vex/js/vex"
    "vex.dialog": "../../../components/vex/js/vex.dialog"
    "modernizr": "../../../components/modernizr/modernizr"
    "foundation": "../../../components/bower-foundation/js/foundation/foundation"
    "foundation.tabs": "../../../components/bower-foundation/js/foundation/foundation.tab"
    "foundation.topbar": "../../../components/bower-foundation/js/foundation/foundation.topbar"
    "autolink": "../../../components/autolink/autolink-min"
    "jquery.countdown": "../../../components/jquery.countdown/dist/jquery.countdown.min"
    "slick": "../../../components/slick.js/slick/slick"
    "card": "../../../components/card/lib/card"
    "jade.templates": "../../templates/jade"

  shim:
    underscore:
      exports: "_"

    backbone:
      deps: [
        "jquery"
        "underscore"
      ]
      exports: "Backbone"

    jade:
      deps: [
        "moment"
      ]

    humanize:
      exports: "Humanize"

    foundation:
      deps: [
        "jquery"
      ]
      exports: "Foundation"

    "foundation.topbar":
      deps: ["foundation"]

    "foundation.tabs":
      deps: ["foundation"]