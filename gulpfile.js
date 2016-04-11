var gulp   = require('gulp');
var coffeeify = require('gulp-coffeeify');
var ejs = require('ejs');
var sass   = require('gulp-sass');

var concat = require('gulp-concat');
var uglify = require('gulp-uglify');
var clean = require('gulp-clean');


var precompileTemplate = function (template) {
    return 'module.exports = ' + ejs.compile(template, {client: true}) + '';
};

gulp.task('clean', function () {
    return gulp.src('web/bundles/app/*', {read: false})
        .pipe(clean());
});

gulp.task('scripts', ['clean'], function () {
    gulp.src('app/Resources/assets/scripts/app.coffee')
        .pipe(coffeeify({
            transforms: [
                {ext: '.ejs', transform: precompileTemplate}
            ]
        }))
        .pipe(gulp.dest('web/bundles/app/js'))
});

gulp.task('styles', ['clean'], function () {
    gulp.src('app/Resources/assets/fonts/**/*')
        .pipe(gulp.dest('web/bundles/app/fonts'));

    gulp.src('app/Resources/assets/styles/user.scss')
        .pipe(sass())
        .pipe(concat('app.css'))
        .pipe(gulp.dest('web/bundles/app/css'))
});


gulp.task('default', ['scripts', 'styles']);