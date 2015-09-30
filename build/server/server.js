// Generated by LiveScript 1.4.0
(function(){
  var url, express, bodyParser, storage, config, x$;
  url = require('url');
  express = require('express');
  bodyParser = require('body-parser');
  storage = require('./storage');
  config = require('../../config.json');
  x$ = express();
  x$.use(express['static']('build'));
  x$.use(function(req, res, next){
    var pathname, id;
    pathname = function(it){
      return it.pathname;
    }(
    url.parse(
    req.url));
    id = pathname.substring(1 + pathname.lastIndexOf('/'));
    if (!id.match(/^\d{4}\w{6}$/)) {
      next();
      return;
    }
    pathname = pathname.substring(1, pathname.lastIndexOf('/'));
    res.sendFile(pathname + "/index.html", {
      root: './build/'
    }, function(err){
      if (err) {
        next();
      }
    });
  });
  x$.use(bodyParser.urlencoded({
    extended: false
  }));
  x$.post('*/upload', function(req, res){
    var service, i$, ref$, len$, s;
    for (i$ = 0, len$ = (ref$ = config.services).length; i$ < len$; ++i$) {
      s = ref$[i$];
      if (~req.url.indexOf(s)) {
        service = s;
        break;
      }
    }
    if (!(service in storage)) {
      res.writeHead(404);
      res.end();
      return;
    }
    storage[service](req.body, function(id){
      if (id == null) {
        res.writeHead(400);
        res.end();
        return;
      }
      res.writeHead(200);
      res.end(id);
    });
  });
  x$.listen(process.env.PORT || 9980);
}).call(this);
