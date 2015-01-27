module.exports = (grunt) ->
  
  # Project configuration
  grunt.initConfig
    pkg: grunt.file.readJSON("package.json")
    paths:
      dist: "assets/dist"
      src: "assets/src"
    
    # JSHint JavaScript files
    jshint:
      files: ["Gruntfile.js", "package.json"]

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
        dest: "<%= paths.dist %>/scripts/",
        ext: ".js"
    
    # Compile Sass to CSS -  destination : source
    sass:
      server:
        files:
          "<%= paths.dist %>/styles/main.css": "<%= paths.src %>/styles/main.sass"

      dist:
        options:
          outputStyle: "compressed"
          sourceComments: "normal"

        files:
          "<%= paths.dist %>/styles/main.css": "<%= paths.src %>/styles/main.sass"

    # Compile Jade files
    jade:
      compile:
        options:
          client: true
          namespace: "jade.templates"
          amd: true
          processName: (filename) ->
            name = filename.replace ".jade", ""
            name = name.replace "assets/src/templates/", ""
            name = name.replace "/", "."
            return name
          data:
            debug: false
        files:
          "<%= paths.dist %>/templates/jade.js": ["<%= paths.src %>/templates/**/*.jade"]

    autoprefixer:
      options: ["last 1 version"]
      dist:
        files: [
          expand: true
          cwd: "<%= paths.dist %>/styles/"
          src: "{,*/}*.css"
          dest: "<%= paths.dist %>/styles/"
        ]

    concurrent:
      serve: ["coffee", "sass:server", "autoprefixer"]
      dist: ["jshint", "coffee", "sass:dist", "jade", "autoprefixer"]

    
    # Simple config to run sass, jshint and coffee any time a js or sass file is added, modified or deleted
    watch:
      coffee:
        files: ["<%= paths.src %>/scripts/**/*.coffee"]
        tasks: ["coffee"]

      sass:
        files: ["<%= paths.src %>/styles/{,*/}*.scss", "<%= paths.src %>/styles/{,*/}*.sass"]
        tasks: ["sass:server", "autoprefixer"]

      jade:
        files: ["<%= paths.src %>/templates/**/*.jade"]
        tasks: ["jade"]

      jshint:
        files: ["<%= jshint.files %>"]
        tasks: ["jshint"]
  
  # Load the plug-ins
  require("load-grunt-tasks") grunt
  
  # Default tasks
  grunt.registerTask "default", ["concurrent:dist"]
  grunt.registerTask "serve", ["concurrent:serve", "watch"]