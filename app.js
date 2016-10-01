const express = require('express');
const app = express();

const siteMetadata = {
    title: 'Spring Board',
    mapsApiKey: 'AIzaSyA7jFnXk_ZPHIQaTiH9qr9FikI2vl67mvA'
};

app.set('view engine', 'pug');
app.set('views', './views');

app.use(express.static('public'));

app.get('/', (req, res) => {
    res.render('index', siteMetadata);
});

app.get('/:page', (req, res) => {
    res.render(req.params.page, siteMetadata);
});

const port = 3000;
app.listen(port, () => console.log(`Running on port ${port}...`));
