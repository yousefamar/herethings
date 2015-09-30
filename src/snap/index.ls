require! {
  './index.styl'

  'common/misc.js'
  'common/utils.ls'
  './snapapp.js': { SnapApp }
}

window.g_content-box-inner-removed = false

document.add-event-listener \DOMContentLoaded !->
  utils.apply-service-links!
  utils.insert-ads!

  window.g_local-media-stream = null
  window.g_countdown = null
  window.g_interval-id = null

  window.g_do-countdown = !->
    --window.g_countdown
    console.log window.g_countdown + \s
    countdown = document.get-element-by-id \countdown
    countdown.inner-HTML = window.g_countdown
    return unless window.g_countdown is 0
    window.snap-app.snap-photo!
    window.clear-interval window.g_interval-id

  window.g_startCountdown = !->
    if window.g_interval-id?
      window.clear-interval window.g_interval-id
      window.g_interval-id = null
    window.g_countdown = 5
    window.g_interval-id = window.set-interval window.g_do-countdown, 1000ms

  window.snap-app = new SnapApp!
    ..init!
