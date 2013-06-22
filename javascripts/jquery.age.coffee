###
jQuery Age
Copyright 2013 Kevin Sylvestre
###

"use strict"

$ = jQuery

class Age

  @singular: 1
  @settings:
    interval: 1000
    suffixes: 
      past: "ago"
      future: "until"
    formats:
      now: "now"
      singular:
        seconds: "a second"
        minutes: "a minute"
        hours: "a hour"
        days: "a day"
        weeks: "a week"
        months: "a month"
        years: "a year"
      plural:
        seconds: "{{amount}} seconds"
        minutes: "{{amount}} minutes"
        hours: "{{amount}} hours"
        days: "{{amount}} days"
        weeks: "{{amount}} weeks"
        months: "{{amount}} months"
        years: "{{amount}} years"

  constructor: ($el, settings = {}) ->
    @$el = $el
    @settings = $.extend {}, Age.settings, settings

    @reformat()
    setInterval @reformat, @settings.interval

  reformat: =>
    @$el.html(@text())

  date: =>
    attribute = @$el.attr('datetime') or @$el.attr('date') or @$el.attr('time')
    new Date(attribute)

  suffix: (interval) =>
    return @settings.suffixes.past if interval < 0
    return @settings.suffixes.future if interval > 0

  formatting: (interval) =>
    seconds: Math.round(Math.abs(interval / (1000)))
    minutes: Math.round(Math.abs(interval / (1000 * 60)))
    hours:   Math.round(Math.abs(interval / (1000 * 60 * 60)))
    days:    Math.round(Math.abs(interval / (1000 * 60 * 60 * 24)))
    weeks:   Math.round(Math.abs(interval / (1000 * 60 * 60 * 24 * 7)))
    months:  Math.round(Math.abs(interval / (1000 * 60 * 60 * 24 * 30)))
    years:   Math.round(Math.abs(interval / (1000 * 60 * 60 * 24 * 365)))

  amount: (formatting) =>
    formatting.years or 
    formatting.months or 
    formatting.weeks or 
    formatting.days or 
    formatting.hours or 
    formatting.minutes or 
    formatting.seconds or
    0

  unit: (formatting) =>
    (formatting.years and "years") or
    (formatting.months and "months") or
    (formatting.weeks and "weeks") or
    (formatting.days and "days") or
    (formatting.hours and "hours") or
    (formatting.minutes and "minutes") or
    (formatting.seconds and "seconds") or 
    undefined

  format: (amount, unit) =>
    @settings.formats[if amount is @singular then 'singular' else 'plural']?[unit]

  text: =>
    interval = (@date() - new Date)
    suffix = @suffix(interval)
    formatting = @formatting(interval)
    amount = @amount(formatting)
    unit = @unit(formatting)

    format = @format(amount, unit)

    return @settings.formats.now unless format
    return "#{format.replace('{{unit}}', unit).replace('{{amount}}', amount)} #{suffix}"

$.fn.extend
  age: (options = {}) ->
    @each -> new Age($(@), options)
