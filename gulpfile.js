var gulp = require('gulp');
var $    = require('gulp-load-plugins')();

var sassPaths = [
  'public/bower_components/foundation-sites/scss',
  'public/bower_components/motion-ui/src'
];

gulp.task('sass', function() {
  return gulp.src('scss/*.scss')
    .pipe($.sass({
      includePaths: sassPaths,
      outputStyle: 'compressed' // if css compressed **file size**
    })
      .on('error', $.sass.logError))
    .pipe($.autoprefixer({
      browsers: ['last 2 versions', 'ie >= 9']
    }))
    .pipe(gulp.dest('public/css'));
});

gulp.task('default', ['sass'], function() {
  gulp.watch(['scss/**/*.scss'], ['sass']);
});
