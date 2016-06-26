require! {
  './index.styl'

  'common/common.ls'
  'common/misc.js'
  'common/utils.ls'

  recordrtc: RecordRTC
}

class VoiceApp
  init: !->
    self = @

    $ \#contentBoxOverlay .fade-out \fast

    window.g_local-media-stream <-! navigator.get-user-media video: false audio: true, _, !-> window.alert it
    self.recorder = new RecordRTC window.g_local-media-stream, type: \audio mime-type: \audio/ogg bits-per-second: 128000

  toggle-recording: ->
    unless @is-recording
      $ \#recording .trigger \pause
      @recorder.start-recording!
      $ \#recordButton .css \background-position-x \-161px
    else
      self = @
      url <-! @recorder.stop-recording
      $ \#recordButton .css \background-position-x \-80px
      console.log url
      $ \#recording
        ..prop \src url
        ..trigger \play
      # TODO: Enable done button here
    @is-recording = not @is-recording

  clear-recording: ->
    @recorder.clear-recorded-data!

$ !->
  window.voice-app = new VoiceApp!
    ..init!

  utils.on-done (success, error) !->
    data = new FormData!
      ..append \audio window.voice-app.recorder.get-blob!

    $.ajax {
      type: \POST
      url: \upload
      data
      -content-type
      -process-data
      success
      error
    }
