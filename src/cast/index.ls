require! {
  './index.styl'

  'common/misc.js'
  'common/utils.ls'
}


window.g_content-box-inner-removed = false

class CastApp
  init: !->
    $ !-> $ \#contentBox .sketch!
    $ \#contentBoxOverlay .fade-out \fast

  toggle-recording: ->

  clear-recording: ->


document.add-event-listener \DOMContentLoaded !->
  utils.apply-service-links!

  window.cast-app = new CastApp!
    ..init!
