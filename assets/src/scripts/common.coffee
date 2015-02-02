requirejs.config
  baseUrl: "/assets/dist/scripts/app"
  paths:
    "jquery": "/assets/components/jquery/dist/jquery",
    "underscore": "/assets/components/underscore/underscore"
    "backbone": "/assets/components/backbone/backbone"
    "moment": "/assets/components/moment/moment"
    "humanize": "/assets/components/humanize-plus/public/dist/humanize.min"
    "jade": "/assets/components/jade/runtime"
    "mixen": "/assets/components/mixen/mixen.min"
    "jade.templates": "/assets/dist/templates/jade"
    "foundation": "/assets/components/bower-foundation/js/foundation/foundation"
    "foundation.tabs": "/assets/components/bower-foundation/js/foundation/foundation.tab"
    "foundation.topbar": "/assets/components/bower-foundation/js/foundation/foundation.topbar"
    "autolink": "/assets/components/autolink/autolink-min"

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