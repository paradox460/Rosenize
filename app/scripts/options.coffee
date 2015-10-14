'use strict';
$ ->
  chrome.storage.sync.get({'rosenry': 100}, (i) ->
    $('#rosenry').val(i.rosenry).trigger('input')
  )
  chrome.storage.sync.get({'mmm_rate': 100}, (i) ->
    $('#mmm_rate').val(i.mmm_rate).trigger('input')
  )
  chrome.storage.sync.get({'mmm_volume': 100}, (i) ->
    $('#mmm_volume').val(i.mmm_volume).trigger('input')
  )
  $('#rosenry').on('input', ->
    $('.rosen-amount .num').text($(this).val())
  ).on('change', _.debounce(->
    chrome.storage.sync.set({'rosenry': parseInt($(this).val())})
  , 250 ))

  $('#mmm_rate').on('input', ->
    $('.mmm-amount .num').text($(this).val())
  ).on('change', _.debounce(->
    chrome.storage.sync.set({'mmm_rate': parseInt($(this).val())})
  , 250))

  $('#mmm_volume').on('input', ->
    $('.mmm-volume .num').text($(this).val())
  ).on('change', _.debounce(->
    chrome.storage.sync.set({'mmm_volume': parseInt($(this).val())})
  , 250))
