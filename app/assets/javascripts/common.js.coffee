toggleCityMenuOnMobile = (e)->
  if $('#city-menu').hasClass 'on'
    console.log 'Opening...'
    $('#city-menu').slideUp
      easing: 'easeOutExpo'
      complete: ->
        $('#city-menu').removeClass 'on'
  else
    console.log 'Closing...'
    $('#city-menu').slideDown
      easing: 'easeOutExpo'
      complete: ->
        $('#city-menu').addClass 'on'

$ ->
  $('.site-title').lettering()

  enquire.register("screen and (max-width: 767px)",
    match: ->
      console.log "On Mobile"
      $('#city-menu').appendTo('#mobile-menu-wrapper')
      $('#city-menu-trigger').on 'click.dropdown.data-api touchstart.dropdown.data-api', toggleCityMenuOnMobile
    unmatch: ->
      console.log "Not on Mobile"
      $('#city-menu').insertAfter('#city-menu-trigger')
      $('#city-menu-trigger').off 'click.dropdown.data-api touchstart.dropdown.data-api', toggleCityMenuOnMobile
  ).listen()

  $('.notification .dismiss').click (e)->
    e.preventDefault()
    $notficationEl = $(e.currentTarget).parents('.notification');
    $notficationEl.slideUp
      complete: ()->
        $notficationEl.remove()