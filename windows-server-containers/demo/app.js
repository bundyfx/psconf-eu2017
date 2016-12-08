var express = require('express')
var path = require('path');
// http://api.brewerydb.com/v2/?key=6b757c6f59edd9a3eabae917422ee8a4

var app = express()
var port = process.env.PORT || 5000;

// serve static content from this directory
app.use(express.static('assets'));
app.use(express.static('src/views'));

app.get('/', function (req, res) {
    res.send('Hey')
});

app.listen(port, function (err) {
    console.log('running server on port ' + port);
});
