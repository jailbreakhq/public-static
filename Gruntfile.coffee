module.exports = (grunt) ->

  # Project configuration
  grunt.initConfig
    pkg: grunt.file.readJSON "package.json"

    paths:
      static: "static"
      build: "static/build"
      src: "static/src"
      deploy: "static/dist"
      components: "static/components"
    
    # Coffeescript Linter
    coffeelint:
      tests:
        files:
          src: ["<%= paths.src %>/scripts/**/*.coffee"]
      options:
        configFile: "coffeelint.json"

    # CoffeeScript
    coffee:
      options:
        sourceMap: false
        sourceRoot: ""

      glob_to_multiple:
        expand: true,
        flatten: false,
        cwd: "<%= paths.src %>/scripts/",
        src: ["**/*.coffee"],
        dest: "<%= paths.build %>/scripts/",
        ext: ".js"
    
    # Compile Sass to CSS -  destination : source
    sass:
      build:
        options:
          style: "compressed"
          sourceComments: "normal"

        files:
          "<%= paths.build %>/styles/main.css": "<%= paths.src %>/styles/main.sass"
          "<%= paths.build %>/styles/iframe.css": "<%= paths.src %>/styles/iframe.sass"

    # Compile Jade files
    jade:
      compile:
        options:
          client: true
          namespace: "jade.templates"
          amd: true
          processName: (filename) ->
            name = filename.replace ".jade", ""
            name = name.replace "static/src/templates/", ""
            parts = name.split "/"
            if parts.length > 1
              finalName = parts[0] + parts[1].charAt(0).toUpperCase() + parts[1].substr(1)
            else
              finalName = name
            return finalName
          data:
            debug: false
        files:
          "<%= paths.build %>/templates/jade.js": ["<%= paths.src %>/templates/**/*.jade"]
      html:
        options:
          pretty: true
          data:
            debug: true
        files:
          "static/build/html/index.html": "static/src/html/index.jade"
          "static/build/html/iframe.html": "static/src/html/iframe.jade"

    ##
    ## Deployment Configuration
    ##
    requirejs:
      main:
        options: 
          baseUrl: "<%= paths.build %>/scripts/app"
          mainConfigFile: "<%= paths.build %>/scripts/common.js"
          name: "main"
          out: "<%= paths.deploy %>/scripts/main.js"
      iframe:
        options: 
          baseUrl: "<%= paths.build %>/scripts/app"
          mainConfigFile: "<%= paths.build %>/scripts/common.js"
          name: "iframe"
          out: "<%= paths.deploy %>/scripts/iframe.js"

    cssmin:
      deploy:
        files:
          "<%= paths.deploy %>/styles/main.css": "<%= paths.build %>/styles/main.css"
          "<%= paths.deploy %>/styles/iframe.css": "<%= paths.build %>/styles/iframe.css"

    uglify:
      deploy:
        files:
          "<%= paths.deploy %>/scripts/require.js": ["<%= paths.components %>/requirejs/require.js"]
          "<%= paths.deploy %>/scripts/main.js": ["<%= paths.deploy %>/scripts/main.js"]
          "<%= paths.deploy %>/scripts/iframe.js": ["<%= paths.deploy %>/scripts/iframe.js"]
    
    targethtml:
      dev:
        files:
          "<%= paths.static %>/index.html": "<%= paths.build %>/html/index.html"
          "<%= paths.static %>/iframe.html": "<%= paths.build %>/html/iframe.html"
      qa:
        options:
          curlyTags: 
            build: "static-" + (process.env.TRAVIS_BUILD_NUMBER or "local")
        files:
          "<%= paths.static %>/index.html": "<%= paths.build %>/html/index.html"
          "<%= paths.static %>/iframe.html": "<%= paths.build %>/html/iframe.html"
      prod:
        options:
          curlyTags: 
            build: "static-" + (process.env.TRAVIS_BUILD_NUMBER or "local")
        files:
          "<%= paths.static %>/index.html": "<%= paths.build %>/html/index.html"
          "<%= paths.static %>/iframe.html": "<%= paths.build %>/html/iframe.html"

    ##
    ## Watcher Configuation
    ##
    # Simple config to run sass, and coffee any time a js or sass file is added, modified or deleted
    watch:
      coffee:
        files: ["<%= paths.src %>/scripts/**/*.coffee"]
        tasks: ["coffeelint", "coffee"]

      sass:
        files: ["<%= paths.src %>/styles/**/*.scss", "<%= paths.src %>/styles/**/*.sass"]
        tasks: ["sass:build"]

      jade:
        files: ["<%= paths.src %>/templates/**/*.jade"]
        tasks: ["jade:compile"]

      html:
        files: ["<%= paths.src %>/html/**/*.jade"]
        tasks: ["jade:html", "targethtml:dev"]

    concurrent:
      build: ["coffee", "sass:build", "basehtml:dev"]


  # Load the plug-ins
  require("load-grunt-tasks") grunt
  
  # Default tasks
  grunt.registerTask "default", ["concurrent:build"]

  grunt.registerTask "basehtml:dev", ["jade", "targethtml:dev"]
  grunt.registerTask "basehtml:qa", ["jade", "targethtml:qa"]
  grunt.registerTask "basehtml:prod", ["jade", "targethtml:prod"]

  grunt.registerTask "deploy", ["concurrent:build", "requirejs", "cssmin:deploy", "uglify:deploy", "basehtml:qa"]
  grunt.registerTask "deploy:prod", ["concurrent:build", "requirejs", "cssmin:deploy", "uglify:deploy", "basehtml:prod"]
