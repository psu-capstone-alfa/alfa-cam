# put your global javascript extensions here

$.fn.outerHTML = ->
  this.clone().wrap('<div/>').parent().html()

$.fn.toggleDisabled = ->
  currentState = this.attr('disabled') == 'disabled'
  this.attr('disabled', !currentState)

$.fn.present = ->
  this.length > 0
