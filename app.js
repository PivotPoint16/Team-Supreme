const express = require('express');
const app = express();

const mysql = require('mysql');
const connection_pool = mysql.createPool({
  connectionLimit : 10,
  host :'localhost',
  user :'hudadmin',
  password : 'hud@Dm1N',
  database: 'HUDDB'
});

const siteMetadata = {
    title: 'Spring Board',
    mapsApiKey: 'AIzaSyA7jFnXk_ZPHIQaTiH9qr9FikI2vl67mvA'
};

app.use(express.static('public'));
app.set('view engine', 'pug');
app.set('views', './views');

app.get('/', (req, res) => {
    res.render('index', siteMetadata);
});


app.get('/housing-list', (req, res) => {
    connection_pool.query('SELECT * FROM USER_APARTMENT_LISTING_VIEW;', function(err, rows, fields){
                             if(err) throw err;
                             res.setHeader('Content-Type', 'application/json');
                             res.send(JSON.stringify(rows));
                           });
});

app.get('/:page', (req, res) => {
    res.render(req.params.page, siteMetadata);
});

const port = 3000;
app.listen(port, () => console.log(`Running on port ${port}...`));
