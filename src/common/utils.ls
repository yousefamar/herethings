services =
  \sketch
  \snap
  \clip
  \voice
  \cast

nav-to-service = (service) ->
  if window.location.hostname is \localhost
    window.location.pathname = "/#service/"
  else
    window.location.hostname = "here#service.com"

export apply-service-links = !->
  services.for-each (service) !->
    for elem in document.get-elements-by-class-name service + \Icon
      elem.add-event-listener \click !->
        nav-to-service service
