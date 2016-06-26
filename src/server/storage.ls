require! [
  fs
  path
  mkdirp
  moment
  \../../config.json
]

gen-id = ->
  year = new Date!.get-UTC-full-year! - 2014
  day  = moment.utc!.format 'DDDD'
  rand = 'xxxxxx'.replace /[x]/g, -> (Math.random!*36.|.0).to-string 36
  "#year#day#rand"

copy-temp = (temp, destination, callback) !->
  err <-! mkdirp "build/#{path.dirname destination}"
  if err?
    callback err
    return
  fs.create-read-stream temp .pipe fs.create-write-stream "build/#destination"
  callback!

export store = (service, files, callback) !->
  id = gen-id!
  switch service
  | \sketch
    err <-! copy-temp files.image[0].path,  "sketch/uploads/#id.png"
    callback unless err? then id
  | \snap
    err <-! copy-temp files.image[0].path,  "snap/uploads/#id.png"
    callback unless err? then id
  | \clip
    err <-! copy-temp files.video[0].path,  "clip/uploads/#id.webm"
    callback unless err? then id
  | \voice
    err <-! copy-temp files.audio[0].path,  "voice/uploads/#id.ogg"
    callback unless err? then id
  | \shown
    # TODO: Compress manually + gzip?
    err <-! copy-temp files.sketch[0].path, "shown/uploads/#id.json"
    callback! if err?
    err <-! copy-temp files.audio[0].path,  "shown/uploads/#id.ogg"
    callback unless err? then id
  | otherwise
    callback!
