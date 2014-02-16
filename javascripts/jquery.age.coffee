###
jQuery Age
Copyright 2013 Kevin Sylvestre
1.1.7
###

"use strict"

$ = jQuery

class Age

  @settings:
    singular: 1
    interval: 1000
    suffixes: 
      past: "ago"
      future: "until"
    prefixes:
        past: ""
        future: ""
    formats:
      now: "now"
      singular:
        seconds: "a second"
        minutes: "a minute"
        hours: "an hour"
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

  reformat: =>
    interval = @interval()
    @$el.html(@text(interval))

    setTimeout @reformat, @settings.interval

  date: =>
    new Date @$el.attr('datetime') or @$el.attr('date') or @$el.attr('time')

  suffix: (interval) =>
    return @settings.suffixes.past if interval < 0
    return @settings.suffixes.future if interval > 0

  prefix: (interval) =>
    return @settings.prefixes.past if interval < 0
    return @settings.prefixes.future if interval > 0

  adjust: (interval, scale) =>
    Math.floor(Math.abs(interval / scale))

  formatting: (interval) =>
    seconds: @adjust(interval, 1000)
    minutes: @adjust(interval, 1000 * 60)
    hours:   @adjust(interval, 1000 * 60 * 60)
    days:    @adjust(interval, 1000 * 60 * 60 * 24)
    weeks:   @adjust(interval, 1000 * 60 * 60 * 24 * 7)
    months:  @adjust(interval, 1000 * 60 * 60 * 24 * 30)
    years:   @adjust(interval, 1000 * 60 * 60 * 24 * 365)

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
    @settings.formats[if amount is @settings.singular then 'singular' else 'plural']?[unit]

  interval: =>
    @date() - new Date

  text: (interval = @interval()) =>
    suffix = @suffix(interval)
    prefix = @prefix(interval)
    formatting = @formatting(interval)
    amount = @amount(formatting)
    unit = @unit(formatting)

    format = @format(amount, unit)

    return @settings.formats.now unless format
    return "#{prefix} #{format.replace('{{unit}}', unit).replace('{{amount}}', amount)} #{suffix}"

$.fn.extend
  age: (options = {}) ->
    @each -> new Age($(@), options)
