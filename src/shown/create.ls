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

  utils.on-done (success, error) !->
    data = new FormData!
      ..append \sketch new Blob [ JSON.stringify window.shown-app.sketch-recording ], type: \application/json
      ..append \audio  window.shown-app.recorder.get-blob!

    $.ajax {
      type: \POST
      url: \upload
      data
      -content-type
      -process-data
      success
      error
    }

$ window .load !-> $ \#contentBoxOverlay .fade-out \fast
