require! {
  './favicon.ico'
  config
}

nav-to-service = (service) ->
  if window.location.hostname is \localhost
    window.location.pathname = "/#service/"
  else
    window.location.hostname = "here#service.com"

$ !->
  config.services.for-each (service) !->
    for elem in document.get-elements-by-class-name service + \Icon
      elem.add-event-listener \click !->
        nav-to-service service
  $ \.hereThingsLink .click !-> nav-to-service \things
