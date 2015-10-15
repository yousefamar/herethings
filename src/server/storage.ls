require! [ fs, mkdirp, moment, '../../config.json' ]

gen-id = ->
  year = new Date!.get-UTC-full-year! - 2014
  day  = moment.utc!.format 'DDDD'
  rand = 'xxxxxx'.replace /[x]/g, -> (Math.random!*36.|.0).to-string 36
  "#year#day#rand"

save-image = (path, id, data-URL, callback) !->
  data-URL .= replace /^data:image\/png;base64,/ ''
  err <-! mkdirp "build/#path"
  return if err?
  fs.write-file "build/#path/#id.png", data-URL, \base64, callback

module.exports = handlers =
  things: (data, callback) ->
    console.log data
    callback!

  sketch: (data, callback) ->
    id = gen-id!
    err <-! save-image 'sketch/uploads', id, data.img
    if err?
      callback!
      return
    callback id

  snap: (data, callback) ->
    id = gen-id!
    err <-! save-image 'snap/uploads', id, data.img
    if err?
      callback!
      return
    callback id

  clip: (data, callback) ->
    console.log data
    callback!

  voice: (data, callback) ->
    console.log data
    callback!

  cast: (data, callback) ->
    console.log data
    callback!

# Quick sanity check
for service in config.services
  unless service of handlers
    console.warn "WARNING: No server handler for #service service!"
