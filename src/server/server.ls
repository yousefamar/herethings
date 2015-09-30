require! [ express, url ]

express!
  ..use express.static 'build'
  ..use (req, res, next) !->
    pathname = req.url |> url.parse |> (.pathname)
    id = pathname.substring 1 + pathname.last-index-of \/
    unless id.match /^\d{5}\w{5}$/
      next!
      return
    pathname .= substring 1 pathname.last-index-of \/
    err <-! res.send-file "#pathname/index.html", root: './build/'
    next! if err
  ..listen (process.env.PORT or 9980)
