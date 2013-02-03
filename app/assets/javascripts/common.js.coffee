$ ->
  $('.notification .dismiss').click (e)->
    e.preventDefault()
    $notficationEl = $(e.currentTarget).parents('.notification');
    $notficationEl.slideUp
      complete: ()->
        $notficationEl.remove()