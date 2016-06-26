require! {
  'common/misc.js'

  recordrtc: RecordRTC
}

export class ShownApp
  init: !->
    self = @

    $.sketch.tools.recorder =
      on-event: !->
        return unless self.is-recording or it.playback

        event =
          x: it.x or it.page-X - @canvas.offset!.left
          y: it.y or it.page-Y - @canvas.offset!.top

        switch it.type
        | <[ down mousedown touchstart ]>
          event.type = \down
          @start-painting!
        | <[ up mouseup mouseout mouseleave touchend touchcancel ]>
          event.type = \up
          @stop-painting!
          unless it.playback then self.on-sketch-event event

        if @painting
          @action.events.push event
          unless it.playback
            self.on-sketch-event event
            @redraw!

      draw: (action) ->
        $.sketch.tools.marker.draw ...

    $ \#contentBox .sketch default-tool: \recorder

    unless window.resourceID?
      window.g_local-media-stream <-! navigator.get-user-media video: false audio: true, _, !-> window.alert it
      self.recorder = new RecordRTC window.g_local-media-stream, type: \audio mime-type: \audio/ogg bits-per-second: 128000

  toggle-recording: !->
    unless @is-recording
      $ \#recording .trigger \pause
      $ \#contentBoxInner2 .fade-out \fast
      @sketch-recording = []
      @start-time = new Date!
      @reset-playback!
      @recorder.start-recording!
      $ \#recordButton .css \background-position-x \-161px
    else
      self = @
      url <-! @recorder.stop-recording
      $ \#recordButton .css \background-position-x \-80px
      $ \#recording .prop \src url
      self.playback-sketch!
      # TODO: Enable done button here
    @is-recording = not @is-recording

  on-sketch-event: !->
    it.time = new Date! - @start-time
    # TODO: If the coordinates don't change, don't bother storing them
    @sketch-recording.push it

  playback-frame: 0
  playback-time:  0

  reset-playback: !->
    $ \#contentBox
      ..sketch!
        ..stop-painting!
        ..actions = []
        #..action  = []
      ..[0]
        ..get-context \2d .clear-rect 0 0 ..width, ..height
    @playback-frame = 0
    @playback-time  = 0

  sketch-until: (time = -1) !->
    @reset-playback! if time < @playback-time
    while @playback-frame < @sketch-recording.length
      frame = @sketch-recording[@playback-frame]
      break if time >= 0 and frame.time > time
      event = { +playback }
        .. <<<< frame
        ..prevent-default = ->
      canvas = $ \#contentBox
      canvas.sketch!.on-event.call canvas, event
      ++@playback-frame
      @playback-time = frame.time
    $ \#contentBox .sketch!.redraw!

  playback-sketch: !->
    self = @

    @reset-playback!

    recording = $ \#recording
      ..trigger \play
      # NOTE: http://stackoverflow.com/questions/12325787/setting-the-granularity-of-the-html5-audio-event-timeupdate
      ..on \timeupdate !->
        self.sketch-until ..[0].current-time * 1000ms
      ..on \ended !->
        self.reset-playback!
        # NOTE: Works better than with loop attribute
        @current-time = 0
        @play!

    # Refresh at 60Hz
    set-interval !->
      return if recording[0].paused
      self.sketch-until recording[0].current-time * 1000ms
    , 1000ms / 60

  clear-recording: !->
    @recorder.clear-recorded-data!
