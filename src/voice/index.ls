require! {
  './index.styl'

  'common/misc.js'
  'common/utils.ls'
}


class VoiceApp
  init: !->
    on-fail-so-hard = ->

    $ \#contentBoxOverlay .fade-out \fast

    context = new window.AudioContext!

    navigator.get-user-media audio: true, (stream) !->
      microphone = context.create-media-stream-source stream
      filter = context.create-biquad-filter!

      # microphone -> filter -> destination.
      microphone.connect filter
      filter.connect context.destination
    , on-fail-so-hard

  toggle-recording: ->

  clear-recording: ->


document.add-event-listener \DOMContentLoaded !->
  utils.apply-service-links!

  window.voice-app = new VoiceApp!
    ..init!
