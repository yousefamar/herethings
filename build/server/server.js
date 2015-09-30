// Generated by LiveScript 1.4.0
(function(){
  var express, url, x$;
  express = require('express');
  url = require('url');
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
    if (!id.match(/^\d{5}\w{5}$/)) {
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
  x$.listen(process.env.PORT || 9980);
}).call(this);