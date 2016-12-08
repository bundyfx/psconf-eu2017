const util = require('util');
var request = require('request');

var userinput = 'heineken'

function create_querystring(userinput){
  var api = util.format('http://api.brewerydb.com/v2/search?q=%s&type=beer&key=6b757c6f59edd9a3eabae917422ee8a4', userinput);
  return api
}

request(create_querystring(userinput), function (error, response, body) {
  if (!error && response.statusCode == 200) {
    var obj = JSON.parse(body)
    console.log(obj)
  }
})
