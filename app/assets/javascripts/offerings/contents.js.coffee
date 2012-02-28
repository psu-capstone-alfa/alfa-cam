# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  unless ($ 'body.content').present()
    return

  original = $('.content-and-mappings .cloneable') . first()
  $('#add-content') . click (e) ->
    # if this can be done w/o changing to markup,
    # then original.clone(true) could bring along the
    # delete-content handler, and make life easier.
    clone = original.clone(true)
    new_id = Date.now()
    $('input, select, textarea', clone).each ->
      self = $(this)
      self.attr('name', self.attr('name').replace(/content_attributes\]\[(\d+)\]/g, 'content_attributes][' + new_id + ']' ))
      self.attr('id', self.attr('id').replace(/content_attributes_(\d+)/g, 'content_attributes_' + new_id))

    clone.removeClass('cloneable').show()
    clone.insertBefore(original)

    false

  $('.delete-content') . click (e) ->
    self = $(this)

    self . siblings('[name*=_destroy]') . toggleDisabled()
    self . closest('tr') . toggleClass('destroyed')

    label = self . find('span')
    label . text( if (label . text() == 'Delete') then 'Undelete' else 'Delete')
    self . find('i') . toggleClass('icon-remove') . toggleClass('icon-ok')
    self . toggleClass('btn-danger') . toggleClass('btn-warning')

    false