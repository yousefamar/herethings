require! {
  './index.styl'

  'common/misc.js'
  'common/utils.ls'
}


class ClipApp
  init: !->
    on-fail-so-hard = ->

    $ \#contentBoxOverlay .fade-out \fast
    video = document.query-selector \video

    navigator.get-user-media video: true audio: false, (local-media-stream) !->
      document.query-selector \video
        ..src = window.URL.create-object-URL local-media-stream
      window.g_local-media-stream = local-media-stream
    , on-fail-so-hard

  toggle-recording: ->

  clear-recording: ->


document.add-event-listener \DOMContentLoaded !->
  utils.apply-service-links!
  utils.insert-ads!

  window.clip-app = new ClipApp!
    ..init!
