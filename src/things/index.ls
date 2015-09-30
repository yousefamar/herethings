require! {
  './index.styl'

  'common/misc.js'
  'common/utils.ls'
}

document.add-event-listener \DOMContentLoaded !->
  utils.apply-service-links!
  utils.insert-ads!
