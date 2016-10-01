const express = require('express');
const app = express();

app.set('view engine', 'pug');
app.set('views', './views');

app.use(express.static('public'));

app.get('/', function(req, res){
  res.render('index',{title:'Hello HUD'});
});

app.listen(3000, function(){
  console.log('HUD HUD Hudding.');
})
