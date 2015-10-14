'use strict'

xhr = new XMLHttpRequest()

rosens = []

xhr.onload = ->
  rosens = JSON.parse(this.response)
  return

xhr.open("GET", chrome.extension.getURL('scripts/rosens.json'), true)
xhr.send()

rosenry = 100
chrome.storage.sync.get({'rosenry': 100}, (i) ->
  rosenry = i.rosenry
  return
)

audio = new Audio('/audio/mmm.opus')

rosenry = 100
chrome.storage.onChanged.addListener( (i) ->
  rosenry = i.rosenry.newValue
)

mmm_rate = 100
chrome.storage.onChanged.addListener( (i) ->
  mmm_rate = i.mmm_rate.newValue
)
audio.volume = 1.0
chrome.storage.onChanged.addListener( (i) ->
  audio.volume = i.mmm_volume.newValue / 100
)

chrome.webRequest.onBeforeRequest.addListener( (info) ->
  return if Math.round(Math.random() * 100) > rosenry
  i = Math.round(Math.random() * rosens.length)
  newURL = chrome.extension.getURL("images/rosens/#{rosens[i].filename}")
  {redirectUrl: newURL}
, {'urls': ['<all_urls>'], 'types': ['image'] }, ['blocking'] )

playMmm = ->
  return if Math.round(Math.random() * 100) > mmm_rate
  _.debounce( ->
    audio.play()
  , 5000, true )()

chrome.runtime.onMessage.addListener( (request, sender, sendResponse) ->
  if request.event == 'mmm'
    playMmm()
)
