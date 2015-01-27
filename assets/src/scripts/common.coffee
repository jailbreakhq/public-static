requirejs.config
  baseUrl: "assets/"
  paths:
    "jquery": "components/jquery/dist/jquery",
    "underscore": "components/underscore/underscore"
    "backbone": "components/backbone/backbone"
    "jade-runtime": "components/jade/runtime"

  shim:
    backbone:
      deps: [
        "jquery"
        "underscore"
      ]
      exports: "Backbone"

    underscore:
      exports: "_"
