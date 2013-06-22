# jQuery Age

Age is a jQuery plugin that formats and tracks dates and times as human readable text.

## Installation

To install copy the *javascripts* directories into your project and add the following snippet to the header:

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/2.0.2/jquery.min.js" type="text/javascript"></script>
    <script src="javascript/jquery.age.js" type="text/javascript"></script>

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
          hours: "a hour",
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

## Copyright

Copyright (c) 2013 - 2013 Kevin Sylvestre. See LICENSE for details.
