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
    connection_pool.query(`SELECT AL.apartment_id,
                           AL.apartment_street_address,
                           AL.apartment_city,
                           SL.state_name,
                           SL.state_code,
                           AL.apartment_start_date,
                           AL.apartment_end_date
                           FROM APARTMENT_LISTING AS AL JOIN
                           STATE_LIST AS SL
                           ON AL.apartment_state_id = SL.state_id`, function(err, rows, fields){
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
