require! {
  './index.styl'

  'common/common.ls'
}

window.g_content-box-inner-removed = false

$ window .load !-> $ \#contentBoxOverlay .fade-out \fast
