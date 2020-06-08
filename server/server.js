const express = require('express');
const parser = require('body-parser');
const morgan = require('morgan');
const router = require('./router.js');
const compression = require('compression');
const cors = require('cors');
const apicache = require('apicache');
const cache = apicache.middleware;

const app = express();
const PORT = 5000;

app.use(compression());
app.use(parser.json());
app.use(morgan('dev'));
app.use(cors());

app.use(cache('5 minutes'));
app.use('/products', router);

app.get('/loaderio-c135f1a97857b5cd896041374f5d630f/', function (req, res) {
  res.send('loaderio-c135f1a97857b5cd896041374f5d630f');
});

app.listen(PORT, () => {
  console.log(`Listening to Port ${PORT}`);
});

module.exports = app;
