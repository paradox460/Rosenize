'use strict';

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

rosenry = 100
chrome.storage.onChanged.addListener( (i) ->
  rosenry = i.rosenry.newValue
)

chrome.webRequest.onBeforeRequest.addListener( (info) ->
  if Math.round(Math.random() * 100) > rosenry
    return

  i = Math.round(Math.random() * rosens.length)
  newURL = chrome.extension.getURL("images/rosens/#{rosens[i].filename}")
  {redirectUrl: newURL}
, {'urls': ['<all_urls>'], 'types': ['image'] }, ['blocking'] )
