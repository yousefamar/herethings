require! {
  url
  express
  multiparty
  \./storage
  \../../config.json
}

express!
  ..set \views \src
  ..set 'view engine' \pug

  ..use express.static 'build'

  ..use (req, res, next) !->
    if (result = req.hostname.match /here(.+).com/)?
      req.url = \/ + result[1] + req.url
    next!

  ..use express.static 'build'

  ..all \/:service* (req, res, next) !->
    if req.params.service is \things or config.services.includes req.params.service
      req.service = req.params.service
      req.url = req.params[0] or \/
    else if (result = req.hostname.match /here(.+).com/)?
      req.service = result[1]
    next!

  ..get \/ (req, res, next) !->
    unless req.service?
      next!
    else if req.service is \things
      res.render \things/index { page: \index }
    else
      res.render "#{req.service}/create" { req.service, page: \create }

  ..get \/:id (req, res, next) !->
    unless /^\d{4}\w{6}$/.test req.params.id
      res.status 400 .send 'Malformed resource ID'
      return
    res.render "#{req.service}/result" { req.service, page: \result, id: req.params.id, config }

  ..post \/upload (req, res) !->
    err, fields, files <-! new multiparty.Form!.parse req
    if err?
      res.status 500 .send 'File upload failed'
      return

    # TODO: Check file size here and client-side
    id <-! storage.store req.service, files
    unless id?
      res.status 404 .send 'Bad request; data not stored'
      return
    res.send id

  ..listen (process.env.PORT or 8080)
