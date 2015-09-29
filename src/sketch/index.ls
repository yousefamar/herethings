require! {
  './index.styl'

  'common/misc.js'
  'common/utils.ls'
}

window.g_content-box-inner-removed = false

document.add-event-listener \DOMContentLoaded !->
  utils.apply-service-links!

  $ !-> $ \#contentBox .sketch!
  $ \#contentBoxOverlay .fade-out \fast
