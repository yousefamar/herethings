require! {
  './index.styl'

  'common/common.ls'
  'common/misc.js'
  'common/utils.ls'
}

window.g_content-box-inner-removed = false

$ !->
  utils.on-done (success, error) !->
    blob <-! $ \#contentBox .[0].to-blob
    console.log blob
    data = new FormData!
      ..append \image blob

    $.ajax {
      type: \POST
      url: \upload
      data
      -content-type
      -process-data
      success
      error
    }

  $ \#contentBox .sketch!
  $ \#contentBoxOverlay .fade-out \fast
