require! {
  './index.styl'

  'common/common.ls'
  'common/misc.js'
  'common/utils.ls'
}

$ window .load !-> $ \#contentBoxOverlay .fade-out \fast
