$ ->
  flashCallback = ->
    $(".alert").fadeOut()
  $(".flash-message").bind 'click', (ev) =>
    $(".alert").fadeOut()
  setTimeout flashCallback, 2000