const { Pool } = require('pg');
const connectionString =
  // 'postgres://postgres:postgres@host.docker.internal:5432/dbproducts_sdc';
  // 'postgres://postgres:postgres@localhost:5432/dbproducts';
  'postgres://postgres:postgres@52.15.232.164:5432/dbproducts_sdc';

const pool = new Pool({
  connectionString: connectionString,
});

module.exports = {
  getProductList: (data) => {
    const count = data.count || 5;
    if (data.page) {
      const end = count * data.page;
      const start = end - count;
      const query = {
        text:
          'SELECT id, name, slogan, description, category, default_price FROM products WHERE id > $1 and id <= $2;',
        values: [start, end],
      };
      return pool.query(query);
    } else {
      const query = {
        text:
          'SELECT id, name, slogan, description, category, default_price FROM products WHERE id <= $1;',
        values: [count],
      };
      return pool.query(query);
    }
  },

  getProductInfo: (id) => {
    const query = {
      text: 'SELECT * FROM products WHERE id = $1;',
      values: [id],
    };
    return pool.query(query);
  },

  getRelated: (id) => {
    const query = {
      text: 'SELECT related_products FROM related WHERE product_id = $1;',
      values: [id],
    };
    return pool.query(query);
  },

  getStyles: (id) => {
    const query = {
      text: `SELECT id style_id, name, original_price, sale_price, default_style "default?", photos, skus
        FROM styles  
        WHERE product_id = $1;`,
      values: [id],
    };
    return pool.query(query);
  },
};
