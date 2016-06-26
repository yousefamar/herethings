require! {
  './index.styl'

  'common/common.ls'
  'common/misc.js'
  'common/utils.ls'

  './shownapp.ls': { ShownApp }
}

$ !->
  window.shown-app = new ShownApp!
    ..init!

  window.shown-app.sketch-recording <-! $.get-JSON "uploads/#{window.resource-ID}.json" null
  window.shown-app.playback-sketch!

$ window .load !-> $ \#contentBoxOverlay .fade-out \fast
