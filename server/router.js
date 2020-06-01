const express = require('express');
const router = express.Router();
const controller = require('./controllers.js');

router.get('/list', controller.getProductList);
router.get('/:product_id', controller.getProductInfo);
router.get('/:product_id/related', controller.getRelated);
router.get('/:product_id/styles', controller.getStyles);

module.exports = router;
