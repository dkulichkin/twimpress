var serialPort = require('mindset-js-binary-parser'),
    express = require('express'),
    app = express(),
    server = require('http').createServer(app),
    io = require('socket.io').listen(server),
    async = require('async'),
    Cookies = require('cookies'),

    Twitter = require('twitter'),
    twitterClient = new Twitter({
      consumer_key: 'K46rruQOZeYy0fRlVlYOpA',
      consumer_secret: 'apLbL5taf1UegrMRRXcN43tt76lPXRtkZloQ6JVUPOo'
    }),

    isSigned = function(req, res, next) {
      var cookies = new Cookies(req, res, null),
          twauth = twitterClient._readCookie(cookies);

      if (twauth && twauth.user_id && twauth.access_token_secret && twauth.access_token_key) {
        twitterClient.options.access_token_key = twauth.access_token_key;
        twitterClient.options.access_token_secret = twauth.access_token_secret;
        next();
      }
      else {
        res.writeHead(403);
        res.write('User is not signed in');
        res.end();
      }
    };

app.use(express.cookieParser());
app.use(express.session({ secret: 'Averyspecialtwimpresssecretkey' }));

app.get('/is-signed', function(req, res) {

  var cookies = new Cookies(req, res, null),
      twauth = twitterClient._readCookie(cookies),
      isSigned = twauth && twauth.user_id && twauth.access_token_secret ? true : false,
      response = {};

  response.isSigned = isSigned;

  if (isSigned) {
    response.screenName = twauth.screen_name;
    twitterClient.showUser(twauth.screen_name, function(profile) {
      response.profileImg = profile.profile_image_url;
      res.writeHead(200, {"Content-type": 'text/javascript'});
      res.write(req.query.callback + '(' + JSON.stringify(response) + ')');
      res.end();
    });
  }
  else {
    res.writeHead(200, {"Content-type": 'text/javascript'});
    res.write(req.query.callback + '(' + JSON.stringify(response) + ')');
    res.end();
  }

});

app.get('/getTweets', isSigned, function(req, res) {


  var query = req.query.q && req.query.q.replace(/^\s+|\s+$/g, '');

  twitterClient.searchUser(query, {count: 7, lang: 'en'}, function(Users) {

    if (Users.data && Users.data.errors && Users.data.errors[0]) {
      res.writeHead(403);
      res.write(Users.data.errors[0].message);
      res.end();
      return;
    }

    if (!Users.length) {
      res.writeHead(200, {"Content-type": 'text/javascript'});
      res.write(req.query.callback + '([])');
      res.end();
      return;
    }

    function search(user, callback) {
      twitterClient.getUserTimeline({count: 5, trim_user: 1, user_id: user.id, exclude_replies: true, include_rts: true, lang: 'en'}, function(data){
        user.tweets = data;
        callback(null, user);
      });
    }

    async.map(Users, search, function(err, result) {
      if (err) {
        res.writeHead(400);
        res.write(err);
        res.end();
        return;
      }
      res.writeHead(200, {"Content-type": 'text/javascript'});
      res.write(req.query.callback + '(' + JSON.stringify(result) + ')');
      res.end();
    });

  });

});

app.get('/twauth', twitterClient.login('/twauth', 'http://127.0.0.1:9000/#/evaluateTweets'));

io.sockets.on('connection', function (socket) {

  serialPort.open(function () {

    console.log('Serial port opened');
    socket.emit('port-opened');

    serialPort.on('data', function(data) {
      socket.emit('data', data);
    });

    socket.on('disconnect', function () {
      //serialPort.removeAllListeners();
      //serialPort.close();
    });

  });
});

server.listen(8080);
