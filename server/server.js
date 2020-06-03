const express = require('express');
const parser = require('body-parser');
const morgan = require('morgan');
const router = require('./router.js');
const compression = require('compression');
const cors = require('cors');

const app = express();
const PORT = 5000;

app.use(compression());
app.use(parser.json());
app.use(morgan('dev'));
app.use(cors());

app.use('/products', router);

app.get('/loaderio-8c50e223d8ab331d9d64b62df0de6556/', function (req, res) {
  res.send('loaderio-8c50e223d8ab331d9d64b62df0de6556');
});

app.listen(PORT, () => {
  console.log(`Listening to Port ${PORT}`);
});

module.exports = app;
