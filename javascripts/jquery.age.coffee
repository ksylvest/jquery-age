###
jQuery Age
Copyright 2013 Kevin Sylvestre
1.2.3
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
    units: ["years", "months", "weeks", "days", "hours", "minutes", "seconds"]
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
      tiny:
        seconds: "{{amount}}s"
        minutes: "{{amount}}m"
        hours: "{{amount}}h"
        days: "{{amount}}d"
        weeks: "{{amount}}w"
        months: "{{amount}}m"
        years: "{{amount}}y"

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
    return formatting[@unit(formatting)] || 0

  unit: (formatting) =>
    for unit in @settings.units
      return unit if formatting[unit] > 0
    return undefined

  format: (amount, unit) =>
    return @settings.formats[@settings.style]?[unit] if @settings.style?
    @settings.formats[if amount is @settings.singular then 'singular' else 'plural']?[unit]

  interval: =>
    @date() - new Date

  text: (interval = @interval()) =>
    return @settings.pending if interval > 0 and @settings.pending?
    return @settings.expired if interval < 0 and @settings.expired?

    suffix = @suffix(interval)
    prefix = @prefix(interval)
    formatting = @formatting(interval)
    amount = @amount(formatting)
    unit = @unit(formatting)

    format = @format(amount, unit)

    return @settings.formats.now unless format
    return "#{prefix} #{format.replace('{{unit}}', unit).replace('{{amount}}', amount)} #{suffix}".trim()

$.fn.extend
  age: (options = {}) ->
    @each -> new Age($(@), options)
