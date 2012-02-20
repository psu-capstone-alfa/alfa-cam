# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  original = $('.mappings .cloneable') . first()
  $('#add-mapping') . click (e) ->
    # if this can be done w/o changing to markup,
    # then original.clone(true) could bring along the
    # delete-content handler, and make life easier.
    clone = original.clone(true)
    new_id = Date.now()
    $('input, select, textarea', clone).each ->
      input = $(this)
      input.attr('name',
                 input.attr('name').replace(/\[new\]/g,
                                           '[' + new_id + ']'))
      if input.attr('id') != undefined
        input.attr('id',
                   input.attr('id').replace(/_new_/g,
                                            '_'+ new_id + '_'))
    clone.removeClass('cloneable').show()
    clone.insertBefore(original)
    false

  $('.delete-mapping') . click (e) ->
    input = $(this)
    input . siblings('[name*=_destroy]') . toggleDisabled()
    input . closest('tr') . toggleClass('destroyed')
    label = input . find('span')
    label . text( if (label . text() == 'Delete') then 'Undelete' else 'Delete')
    input . find('i') . toggleClass('icon-remove') . toggleClass('icon-ok')
    input . toggleClass('btn-danger') . toggleClass('btn-warning')
    false
