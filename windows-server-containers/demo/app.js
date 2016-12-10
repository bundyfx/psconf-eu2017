var search = require('./src/routes/search.js');
var express = require('express')
var bodyParser = require('body-parser')

//create a new express object
var app = express()

//the port to listen on for my express application
var port = process.env.PORT || 5000;

// serve static content from these directory
app.use(express.static('routes'));
app.use(express.static('assets'));
app.use(express.static('src/views'));
app.set('views', './src/views')

// load ejs as view engine
app.set('view engine', 'ejs');

// defines the /search page
app.get('/search', function (req, res){

  search.create_query(req.query.searchf, function(result){

    //if there are not results render the error page to the user
    if (result.totalResults == null) {
      res.render('error')
    }
    else {
      //send the user to the search page with the results
      res.render('search', { results: result.data, query: req.query.searchf });
    }
    console.log(result.data)
    console.log('Found ' + result.totalResults + ' beers')

  })
})

// defines the default index page
app.get('/', function (req, res){
  res.render('index')
})

// makes our application listen for incoming requests
app.listen(port, function (err) {
    console.log('running server on port ' + port);
});
