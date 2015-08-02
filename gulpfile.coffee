# js
uglify = require 'gulp-uglify'
browserify = require 'browserify'
source = require 'vinyl-source-stream'
streamify = require 'gulp-streamify'
watchify = require 'watchify'
gulp = require 'gulp'
yaml = require 'gulp-yaml'

# css
stylus = require 'gulp-stylus'
cmq = require 'gulp-combine-media-queries'
postcss = require 'gulp-postcss'
autoprefixer = require 'autoprefixer-core'
cssmin = require 'gulp-cssmin'
sourcemaps = require 'gulp-sourcemaps'
nib = require 'nib'

# utilities
nodemon = require 'gulp-nodemon'
args = require('yargs').argv
run = require 'run-sequence'
gulpif = require 'gulp-if'
sync = require 'browser-sync'
notify = require 'gulp-notify'
plumber = require 'gulp-plumber'
rename = require 'gulp-rename'

production = no
production = args.p or args.production

paths =
  browserify: './assets/scripts/app.coffee'
  frontEndOutput: 'app.js'
  html: './assets/template/*.html'
  yaml: './assets/yaml/*.yml'
  stylus: './assets/stylesheets/*.styl'
  deep_stylus: './assets/stylesheets/**/*.styl'
  jade: './views/*.jade'
  dest: './lib/static/generated/'

buildScript = (files, watch) ->
  rebundle = (callback) ->
    stream = bundler.bundle()
    stream
      .on 'error', notify.onError         # optional (for gulp-notify)
        title: 'Compile Error'            #
        message: "<%= error.message %>"   #
      .pipe source paths.frontEndOutput
      .pipe gulpif production, streamify do uglify # optional (for gulp-uglify)
      .pipe gulp.dest paths.dest
      .pipe sync.reload stream: yes      # optional (for browser-sync)

    stream.on 'end', ->
      do callback if typeof callback is 'function'

  props = watchify.args
  props.entries = files
  props.debug = not production

  bundler = if watch then watchify(browserify props) else browserify props
  bundler.transform 'coffeeify' # 'coffeeify' or whatever or comment it
  bundler.on 'update', ->
    now = new Date().toTimeString()[..7]
    console.log "[#{now.gray}] Starting #{"'browserify'".cyan}..."
    startTime = new Date().getTime()
    rebundle ->
      time = (new Date().getTime() - startTime) / 1000
      now = new Date().toTimeString()[..7]
      console.log "[#{now.gray}] Finished #{"'browserify'".cyan} after #{(time + 's').magenta}"

  rebundle()

gulp.task 'browserify', ->                 # compile (slow)
  buildScript paths.browserify, no

gulp.task 'watchjs', ->                    # watch and compile (first time slow, after fast)
  buildScript paths.browserify, yes

gulp.task 'yaml', ->
  gulp.src paths.yaml
    .pipe plumber errorHandler: notify.onError "Error: <%= error.message %>"
    .pipe yaml space: 2
    .pipe rename extname: '.js'
    .pipe gulp.dest './locales/'


gulp.task 'stylus', ->
  gulp.src(paths.stylus)
    .pipe plumber errorHandler: notify.onError "Error: <%= error.message %>"
    .pipe gulpif not production, sourcemaps.init()
    .pipe stylus
      use: [nib()]
      'include css': true
      include: ['node_modules/']
      compress: production
      import: ['nib']
    .pipe gulpif production, cmq()
    .pipe postcss [ autoprefixer browsers: ['last 2 version', '> 1%'] ]
    .pipe gulpif production, cssmin()
    .pipe gulpif not production, sourcemaps.write()
    .pipe gulp.dest paths.dest
    .pipe sync.reload stream: true

gulp.task 'browser-sync', ->
  sync
    notify: false
    open: false
    proxy: 'localhost:5000'
    snippetOptions: rule:
      match: /<\/body>/i
      fn: (snippet, match) ->
        snippet + match

gulp.task 'default', ->
  run 'yaml', 'stylus', 'browserify'

gulp.task 'watch', ['browser-sync', 'watchjs'], ->
  gulp.watch paths.yaml, ['yaml']
    .on 'change', sync.reload
  gulp.watch paths.deep_stylus, ['stylus']
  gulp.watch paths.jade
    .on 'change', sync.reload
  nodemon
    script: 'index.coffee'
    watch: ['index.coffee', 'modules/*.coffee']
