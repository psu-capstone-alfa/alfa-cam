# Fancy dynamic save/continue form buttons


$ ->
  form = $('form.fancy-buttons')
  form.addClass 'pristine'
  form.removeClass 'changed'

  form.change ->
    form.addClass 'changed'
    form.removeClass 'pristine'
    $('.form-actions .continue',form).attr 'disabled', 'disabled'
  form.bind 'reset', ->
    form.addClass 'pristine'
    form.removeClass 'changed'
    $('.form-actions .continue',form).removeAttr 'disabled'
  form.submit ->
    form.addClass 'submitting'

  window.onbeforeunload = ->
    if form.hasClass 'changed' && ! form.hasClass 'submitting'
      'There are unsaved changes,'
