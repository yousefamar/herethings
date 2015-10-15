require! {
  './index.styl'

  'common/misc.js'
  'common/utils.ls'
  './snapapp.js': { SnapApp }
}

window.g_content-box-inner-removed = false

document.add-event-listener \DOMContentLoaded !->
  utils.apply-service-links!

  unless (id = utils.get-id!)?
    $ \#content-inner .html (require './create.jade')!

    window
      ..g_local-media-stream = null
      ..g_countdown = null
      ..g_interval-id = null

      ..g_do-countdown = !->
        --window.g_countdown
        console.log window.g_countdown + \s
        countdown = document.get-element-by-id \countdown
        countdown.inner-HTML = window.g_countdown
        return unless window.g_countdown is 0
        window.snap-app.snap-photo!
        window.clear-interval window.g_interval-id

      ..g_startCountdown = !->
        if window.g_interval-id?
          window.clear-interval window.g_interval-id
          window.g_interval-id = null
        window.g_countdown = 5
        window.g_interval-id = window.set-interval window.g_do-countdown, 1000ms

      ..snap-app = new SnapApp!
        ..init!

    $ \.doneButton .click !->
      $ \.doneButton .off \click
      $.post \upload img: ($ \#canvas .[0].to-data-URL \image/png)
        .done utils.on-upload-success
        .fail utils.on-upload-fail

    return

  $ \#content-inner .html (require './result.jade')!

  utils.insert-ads!

  img = new Image!
  img.src = utils.create-asset-URL "uploads/#id.png"
  img.onload = !->
    # TODO: Warning, hardcoded height here
    vertical-offset = 0.5 * (600 - img.height)
    $ \#contentBox .[0].get-context \2d .draw-image img, 0 vertical-offset
    $ \#contentBoxOverlay .fade-out \fast
