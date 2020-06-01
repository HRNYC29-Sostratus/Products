const express = require('express');
const parser = require('body-parser');
const morgan = require('morgan');
const router = require('./router.js');

const app = express();
const PORT = 5000;

app.use(parser.json());
app.use(morgan('dev'));

app.use('/products', router);

app.listen(PORT, () => {
  console.log(`Listening to Port ${PORT}`);
});
