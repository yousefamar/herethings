require! [ url, express, 'body-parser', './storage', '../../config.json' ]

express!
  ..use express.static 'build'

  ..use (req, res, next) !->
    pathname = req.url |> url.parse |> (.pathname)
    id = pathname.substring 1 + pathname.last-index-of \/
    unless id.match /^\d{4}\w{6}$/
      next!
      return
    pathname .= substring 1 pathname.last-index-of \/
    err <-! res.send-file "#pathname/index.html", root: './build/'
    next! if err

  ..use body-parser.urlencoded extended: false

  ..post '*/upload' (req, res) !->
    var service
    for s in config.services
      if ~req.url.index-of s
        service = s
        break
    unless service of storage
      # Service doesn't exist yet
      res.write-head 404
      res.end!
      return
    id <-! storage[service] req.body
    unless id?
      # Bad request; data not stored
      res.write-head 400
      res.end!
      return
    res.write-head 200
    res.end id

  ..listen (process.env.PORT or 9980)
