require! config

get-id = ->
  id = window.location.pathname.substring 1 + window.location.pathname.last-index-of \/
  return id if id.match /^\d{4}\w{6}$/

export create-asset-URL = (path) -> config.maxCDNURL + path

on-upload-success = do ->
  require! 'jquery-ui/effect-shake'
  !->
    window.history.replaceState {}, 'Unique URL', "#{window.location.pathname}#it"
    $ \#linkPointer
      ..fade-in  \fast
      ..effect   \shake direction: \up times: 2 distance: 5
        , 2000
      ..delay 3000
      ..fade-out \fast

on-upload-fail = !->
  console.error 'Fail ', it

export on-done = (upload) !->
  # TODO: Disable by default
  $ \.doneButton .click !->
    $ \.doneButton .off \click
    new Promise upload
      .then  on-upload-success
      .catch on-upload-fail
