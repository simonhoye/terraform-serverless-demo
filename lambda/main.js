'use strict';

exports.handler = function (event, context, callback) {
  var response = {
    statusCode: 200,
    headers: {
      'Content-Type': 'text/html; charset=utf-8',
    },
    body: "<p>Hello World v1.0.1</p>",
  };
  callback(null, response);
};