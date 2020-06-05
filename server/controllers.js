const db = require('../db/db-model.js');

module.exports = {
  getProductList: (req, res) => {
    db.getProductList(req.query)
      .then((results) => {
        res.json(results.rows);
      })
      .catch((err) => {
        res.sendStatus(404);
      });
  },

  getProductInfo: (req, res) => {
    db.getProductInfo(req.params.product_id)
      .then((results) => {
        res.json(results.rows[0]);
      })
      .catch((err) => {
        res.sendStatus(404);
      });
  },

  getRelated: (req, res) => {
    db.getRelated(req.params.product_id)
      .then((results) => {
        res.json(results.rows[0].related_products);
      })
      .catch((err) => {
        res.sendStatus(404);
      });
  },

  getStyles: (req, res) => {
    db.getStyles(req.params.product_id)
      .then((results) => {
        let resultBody = {
          product_id: req.params.product_id,
          results: results.rows,
        };
        res.json(resultBody);
      })
      .catch((err) => {
        res.sendStatus(404);
      });
  },
};
