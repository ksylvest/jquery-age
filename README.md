# jQuery Age

Age is a jQuery plugin that formats and tracks dates and times as human readable text.

## Installation

To install copy the *javascripts* directories into your project and add the following snippet to the header:

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js" type="text/javascript"></script>
    <script src="javascript/jquery.age.js" type="text/javascript"></script>

This plugin is also registered under http://bower.io/ to simplify integration. Try:

    npm install -g bower
    bower install gridly

In addition this plugin is registered as a https://rails-assets.org/ to simplify integration with Ruby on Rails applications:

**Gemfile**

    + source 'https://rails-assets.org'
    ...
    + gem 'rails-assets-age'

**application.js**

    //= require jquery
    ...
    //= require age

## Examples

Setting up a date or time is easy. The following snippet is a good start:

    <time datetime="2010-01-01T12:00:00Z" class="age">January 1, 2010 12:00</time>
    <time datetime="2020-01-01T12:00:00Z" class="age">January 1, 2020 12:00</time>

    <script type="text/javascript">
      $('.age').age();
    </script>

## Configuration

Age supports a number of configuration settings for customizing the language and intervals:

    $('.age').age({
      interval: 10000,
      suffixes: {
        past: "ago",
        future: "until",
        },
      formats: {
        now: "now"
        singular: {
          seconds: "a second",
          minutes: "a minute",
          hours: "an hour",
          days: "a day",
          weeks: "a week",
          months: "a month",
          years: "a year",
          },
        plural: {
          seconds: "{{amount}} seconds",
          minutes: "{{amount}} minutes",
          hours: "{{amount}} hours",
          days: "{{amount}} days",
          weeks: "{{amount}} weeks",
          months: "{{amount}} months",
          years: "{{amount}} years",
          },
        },
      });
    );

Age also supports passing in a whitelist of allowed units (i.e. now showing units in weeks or months ever):

    $('.age').age({ units: ["days", "hours", "minutes"] });

## Contributors

- Carlos Manuel Escalona Villeda

## Status

[!(https://img.shields.io/travis/ksylvest/jquery-age.svg)](https://travis-ci.org/ksylvest/jquery-age)
[!(https://img.shields.io/codeclimate/github/ksylvest/jquery-age.svg)](https://codeclimate.com/github/ksylvest/jquery-age)

## Copyright

Copyright (c) 2013 - 2014 Kevin Sylvestre. See LICENSE for details.
