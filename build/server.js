// Generated by LiveScript 1.4.0
(function(){
  var express, x$;
  express = require('express');
  x$ = express();
  x$.use(express['static']('build'));
  x$.use(function(req, res){
    res.sendFile('build/index.html', {
      root: './'
    });
  });
  x$.listen(process.env.PORT || 9980);
}).call(this);