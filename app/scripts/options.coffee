'use strict';
$ ->
  chrome.storage.sync.get({'rosenry': 100}, (i) ->
    $('#rosenry').val(i.rosenry).trigger('input')
  )
  $('#rosenry').on('input', ->
    $('.rosen-amount .num').text($(this).val())
  ).on('change', _.debounce(->
    chrome.storage.sync.set({'rosenry': parseInt($(this).val())})
  , 250 ))
