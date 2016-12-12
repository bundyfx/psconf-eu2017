const util = require('util');
var request = require('request')

var key = process.env.apikey

module.exports = {

  create_query: function (userinput, callback){
  var api = util.format('http://api.brewerydb.com/v2/search?q=%s&type=beer&key=%s', userinput, key);

  request(api, function (error, response, body) {
   if (!error && response.statusCode == 200) {
     var obj = JSON.parse(body)
     callback(obj);
   }
  })
 }
}
