const express = require('express');
const app = express();

app.set('view engine', 'pug');
app.set('views', './views');

app.use(express.static('public'));

app.get('/', (req, res) => {
    res.render('index', {
        title: 'Spring Board'
    });
});

const port = 3000;
app.listen(port, () => console.log(`Running on port ${port}...`));
