require! '../../config.json'

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
  return unless config.show-ads

  document.create-element \script
    ..async = true
    ..src = '//pagead2.googlesyndication.com/pagead/js/adsbygoogle.js'
    document.body.append-child ..

  ad-div = document.create-element \div
    ..style.text-align = \center
    document.body.append-child ..

  document.create-element \ins
    ..class-name = \adsbygoogle
    ..style
      ..display = \inline-block
      ..width   = \468px
      ..height  = \60px
    ..['data-ad-client'] = \ca-pub-4135663670627621
    ..['data-ad-slot'] = \3009112240
    ad-div.append-child ..

  window.adsbygoogle = window.adsbygoogle or []
    ..push {}
