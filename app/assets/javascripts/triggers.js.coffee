# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

window.toggleElements = (elements) ->
  arrayLength = elements.length
  i = 0
  while i < arrayLength
    el = document.getElementById(elements[i])
    if el.style.display != 'none'
      el.style.display = 'none'
    else
      el.style.display = ''
    i++
  return

