export services =
  \sketch
  \snap
  \clip
  \voice
  \cast

export nav-to-service = (service) ->
  if window.location.hostname is \localhost
    window.location.pathname = "/#service/"
  else
    window.location.hostname = "here#service.com"
