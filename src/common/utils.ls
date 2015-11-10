require! config

nav-to-service = (service) ->
  if window.location.hostname is \localhost
    window.location.pathname = "/#service/"
  else
    window.location.hostname = "here#service.com"

export apply-service-links = !->
  config.services.for-each (service) !->
    for elem in document.get-elements-by-class-name service + \Icon
      elem.add-event-listener \click !->
        nav-to-service service

export insert-ads = !->
  unless config.show-ads
    # TODO: Un-hackify all absolute positioning stuff
    $ \.bottomAdFootnote .css \top \615px
    return

  document.create-element \script
    ..async = true
    ..src = '//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js'
    document.body.append-child ..

  window.adsbygoogle = window.adsbygoogle or []
    ..push {}

export get-id = ->
  id = window.location.pathname.substring 1 + window.location.pathname.last-index-of \/
  return id if id.match /^\d{4}\w{6}$/

export create-asset-URL = (path) -> config.maxCDNURL + path

export on-upload-success = do ->
  require! 'jquery-ui/effect-shake'
  require! 'common/includes/waggle.jade'
  !->
    window.history.replaceState {}, 'Unique URL', "#{window.location.pathname}#it"
    $ waggle!
      $ \body .append ..
      ..fade-in  \fast
      ..effect   \shake direction: \up times: 20 distance: 15
      , 20000
      ..fade-out \fast

export on-upload-fail = !->
  console.error 'Fail ', it
