DROP TABLE IF EXISTS PRODUCTS;
CREATE TABLE PRODUCTS (
  id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(100),
  slogan VARCHAR(500),
  description VARCHAR(2000),
  category VARCHAR(50),
  default_price INTEGER,
  features JSON
);

DROP TABLE IF EXISTS RELATED;
CREATE TABLE RELATED (
  product_id INTEGER NOT NULL PRIMARY KEY,
  related_products JSON
);

DROP TABLE IF EXISTS STYLES;
CREATE TABLE STYLES (
  id INTEGER NOT NULL PRIMARY KEY,
  product_id INTEGER,
  name VARCHAR(500),
  sale_price VARCHAR(50),
  original_price INTEGER,
  default_style INTEGER,
  skus JSON,
  photos JSON
);

ALTER TABLE styles
  ADD CONSTRAINT constraint_styles_fkey FOREIGN KEY (product_id) REFERENCES products (id);

CREATE INDEX idx_styles_prod_id 
  ON styles(product_id);

CREATE INDEX idx_products_id 
  ON products(id);


-- COMMANDS IN DOCKER

-- Run Postgres Database
-- docker run --name sdc-dbpg -e POSTGRES_PASSWORD=postgres -p 5432:5432 -v pgdata:/var/lib/postgresql/data postgres 
-- Run API server
-- docker build -t olivercomia/sdc-server .
-- docker run --name server-api -p 5000:5000 -d olivercomia/sdc-server