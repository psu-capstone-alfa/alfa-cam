# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  unless ($ 'body.content').present()
    return

  $('.add-content') . click (e) ->
    # if this can be done w/o changing to markup,
    # then original.clone(true) could bring along the
    # delete-content handler, and make life easier.
    button = $ this
    container = button.closest('tbody')
    clone = container.find('tr.cloneable').clone(true)
    new_id = Date.now()
    $('input, select, textarea', clone).each ->
      self = $ this
      self.attr('name', self.attr('name').replace(/content_attributes\]\[(\d+)\]/g, 'content_attributes][' + new_id + ']' ))
      if self.attr('id') != undefined
        self.attr('id', self.attr('id').replace(/content_attributes_(\d+)/g, 'content_attributes_' + new_id))
    $('label', clone).each ->
      label = $(this)
      if label.attr('for') != undefined
        label.attr('for', label.attr('for').replace(/content_attributes_(\d+)/g, 'content_attributes_' + new_id))

    clone.removeClass('cloneable').show()
    clone.insertBefore(container.find('#content-footer'))

    false

  $('div.content-group') . each ->
    group = $ this
    existing = group . find '.content:not(.cloneable)'
    unless existing.present()
      group.find('.add-content').click()

  $('.delete-content') . click (e) ->
    self = $(this)
    self . closest('tr') . toggleClass('destroyed')
    self . find('i') . toggleClass('icon-remove') . toggleClass('icon-ok')
    self . toggleClass('btn-danger') . toggleClass('btn-warning')

