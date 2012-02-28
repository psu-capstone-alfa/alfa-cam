# wires up all the fanciness for staff bulk offering creation
$ ->
  # hide all but one list of instructor courses
  $('#courses > div').not(':first').hide()

  # highlight the active instructor
  $('#instructors button:first').addClass 'active btn-primary'

  # hide all the destroy checkboxes
  $('[name*=_destroy]:checkbox')

  # switch to courses for the selected instructor
  $('#instructors button').click (event)->
    $('#instructors button').removeClass 'active btn-primary'
    $(this).addClass 'active btn-primary'
    $('#courses > div').hide()
    $('#courses #course-' + this.value).show()
    false

  # toggle all buttons matching this instructor-course
  # and disable/enable the _destroy input for this offering
  # 2 cases:
  # - this is a new (potential) offering:
  #   - the _destroy input is enabled on render
  #   - therefore, if the button is never clicked the record is ignored
  #   - after button clicked, _destroy is disabled, so record is created
  # - this is an existing offering:
  #   - the _destroy input is disabled on render
  #   - if the button is clicked, then _destroy is enabled and the
  #     record will be deleted
  $('#courses button').click (event)->
    buttons = $ 'button[value=' + ($ this).val() + ']'
    buttons.toggleClass 'btn-primary active'
    destroy_disabled = buttons.siblings('[name*=_destroy]').attr('disabled')
    disabled = destroy_disabled != 'disabled'
    buttons.siblings('[name*=_destroy]').attr('disabled', disabled)
    false