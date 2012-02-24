# wires up all the fanciness for staff bulk offering creation
$ ->
  # hide all but one list of instructor courses
  $('#courses > div').not(':first').hide()

  # highlight the active instructor
  $('#instructors button:first').addClass 'active btn-primary'

  # switch to courses for the selected instructor
  $('#instructors button').click (event)->
    $('#instructors button').removeClass 'active btn-primary'
    $(this).addClass 'active btn-primary'
    $('#courses > div').hide()
    $('#courses #course-' + this.value).show()
    false

  # toggle all buttons matching this instructor-course
  $('#courses button').click (event)->
    buttons = $ 'button[value=' + ($ this).val() + ']'
    buttons.toggleClass 'btn-primary active'
    # TODO:eo add/remove (enable/disable?) a hidden form
    # field for this pair
