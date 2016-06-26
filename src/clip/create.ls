require! {
  './index.styl'

  'common/common.ls'
  'common/misc.js'
  'common/utils.ls'

  recordrtc: RecordRTC
}

class ClipApp
  init: !->
    self = @

    $ \#contentBoxOverlay .fade-out \fast
    video = document.query-selector \video

    window.g_local-media-stream <-! navigator.get-user-media video: true audio: true, _, !-> window.alert it
    $ \#contentBox .attr \src window.URL.create-object-URL window.g_local-media-stream
    self.recorder = new RecordRTC window.g_local-media-stream, type: \video mime-type: \video/webm bits-per-second: 128000

  toggle-recording: ->
    unless @is-recording
      $ \#contentBox
        ..prop \muted true
        ..prop \src window.URL.create-object-URL window.g_local-media-stream
      @recorder.start-recording!
      $ \#recordButton .css \background-position-x \-161px
    else
      self = @
      url <-! @recorder.stop-recording
      $ \#recordButton .css \background-position-x \-80px
      $ \#contentBox
        ..remove-attr \muted
        ..prop \muted false
        ..prop \src url
      # TODO: Enable done button here
    @is-recording = not @is-recording

  clear-recording: ->
    @recorder.clear-recorded-data!

$ !->
  window.clip-app = new ClipApp!
    ..init!

  utils.on-done (success, error) !->
    data = new FormData!
      ..append \video window.clip-app.recorder.get-blob!

    $.ajax {
      type: \POST
      url: \upload
      data
      -content-type
      -process-data
      success
      error
    }
