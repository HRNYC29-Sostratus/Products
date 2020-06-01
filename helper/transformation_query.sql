DROP TABLE IF EXISTS PRODUCTS_STAGING;
CREATE TABLE PRODUCTS_STAGING (
  id INTEGER NOT NULL PRIMARY KEY,
  name VARCHAR(100),
  slogan VARCHAR(500),
  description VARCHAR(2000),
  category VARCHAR(50),
  default_price INTEGER
);


DROP TABLE IF EXISTS FEATURES_STAGING;
CREATE TABLE FEATURES_STAGING (
  id INTEGER NOT NULL PRIMARY KEY,
  product_id INTEGER,
  feature VARCHAR(50),
  value VARCHAR(50)
);


DROP TABLE IF EXISTS RELATED_STAGING;
CREATE TABLE RELATED_STAGING (
  id INTEGER NOT NULL,
  product_id INTEGER,
  related_product_id INTEGER
);


DROP TABLE IF EXISTS SKUS_STAGING;
CREATE TABLE SKUS_STAGING (
  id INTEGER NOT NULL,
  style_id INTEGER,
  size VARCHAR(10),
  quantity INTEGER
);


DROP TABLE IF EXISTS STYLES_STAGING;
CREATE TABLE STYLES_STAGING (
  id INTEGER NOT NULL,
  product_id INTEGER,
  name VARCHAR,
  sale_price VARCHAR,
  original_price INTEGER,
  default_style INTEGER
);


DROP TABLE IF EXISTS PHOTOS_STAGING;
CREATE TABLE PHOTOS_STAGING (
  id INTEGER NOT NULL,
  style_id INTEGER,
  url VARCHAR,
  thumbnail_url VARCHAR
);


/* Execute creation of Staging Tables */ 
-- \i create_tables.sql

/* Execute copying of data from CSV to Staging Tables */ 
-- \copy products_staging from 'product.csv' csv header; 
-- \copy features_staging from 'features.csv' csv; 
-- \copy related_staging from 'related.csv' csv header; 
-- \copy skus_staging from 'skus.csv' csv header; 
-- \copy styles_staging from 'styles.csv' csv header; 
-- \copy photos_staging from 'photos.csv' csv header;


/* RESULTS in DOCKER 
-- products_sdc=# \copy products_staging from 'product.csv' csv header;
-- COPY 1000011
-- products_sdc=# \copy photos_staging from 'photos.csv' csv header;
-- COPY 13463360
-- products_sdc=# \copy features_staging from 'features.csv' csv;
-- COPY 2218658
-- products_sdc=# \copy related_staging from 'related.csv' csv header;
-- COPY 4510017
-- products_sdc=# \copy skus_staging from 'skus.csv' csv header;
-- COPY 26961739
-- products_sdc=# \copy styles_staging from 'styles.csv' csv header;
-- COPY 4660354
*/


DROP TABLE IF EXISTS PRODUCTS;
create table products as
select  ps.id, ps.name, ps.slogan, ps.description, ps.category, ps.default_price, b.features
from products_staging ps,
(select json_agg(json_build_object('feature', feature, 'value', value)) features, product_id 
from features_staging fs2
group by product_id) b
where ps.id =+ b.product_id
order by ps.id
;

ALTER TABLE products 
ADD PRIMARY KEY (id);

DROP TABLE IF EXISTS PRODUCTS_STAGING;
DROP TABLE IF EXISTS FEATURES_STAGING;


DROP TABLE IF EXISTS RELATED;
create table related as
select product_id, json_agg(related_product_id) related_products from related_staging rs 
group by product_id 
order by product_id ;

DROP TABLE IF EXISTS RELATED_STAGING;

create table skus as
select style_id, json_object_agg(size, quantity) from skus_staging ss 
where style_id <= 2500000
group by style_id
order by style_id;

INSERT INTO skus
select style_id, json_object_agg(size, quantity) from skus_staging ss 
where style_id > 2500000
and style_id <= 4700000
group by style_id
order by style_id;

DROP TABLE IF EXISTS SKUS_STAGING;

create table photos as
select style_id, json_agg(json_build_object('thumbnail_url', thumbnail_url, 'url', url)) photos
from photos_staging ps 
where style_id <= 100000
group by style_id
order by style_id;

INSERT INTO photos
select style_id, json_agg(json_build_object('thumbnail_url', thumbnail_url, 'url', url)) photos
from photos_staging ps 
where style_id > 100000
and style_id <= 300000
group by style_id
order by style_id;

INSERT INTO photos
select style_id, json_agg(json_build_object('thumbnail_url', thumbnail_url, 'url', url)) photos
from photos_staging ps 
where style_id > 300000
and style_id <= 600000
group by style_id
order by style_id;


INSERT INTO photos
select style_id, json_agg(json_build_object('thumbnail_url', thumbnail_url, 'url', url)) photos
from photos_staging ps 
where style_id > 600000
and style_id <= 900000
group by style_id
order by style_id;

INSERT INTO photos
select style_id, json_agg(json_build_object('thumbnail_url', thumbnail_url, 'url', url)) photos
from photos_staging ps 
where style_id > 900000
and style_id <= 1100000
group by style_id
order by style_id;

INSERT INTO photos
select style_id, json_agg(json_build_object('thumbnail_url', thumbnail_url, 'url', url)) photos
from photos_staging ps 
where style_id > 1100000
and style_id <= 1500000
group by style_id
order by style_id;

INSERT INTO photos
select style_id, json_agg(json_build_object('thumbnail_url', thumbnail_url, 'url', url)) photos
from photos_staging ps 
where style_id > 1500000
and style_id <= 2000000
group by style_id
order by style_id;


INSERT INTO photos
select style_id, json_agg(json_build_object('thumbnail_url', thumbnail_url, 'url', url)) photos
from photos_staging ps 
where style_id > 2000000
and style_id <= 2500000
group by style_id
order by style_id;

INSERT INTO photos
select style_id, json_agg(json_build_object('thumbnail_url', thumbnail_url, 'url', url)) photos
from photos_staging ps 
where style_id > 2500000
and style_id <= 3000000
group by style_id
order by style_id;


INSERT INTO photos
select style_id, json_agg(json_build_object('thumbnail_url', thumbnail_url, 'url', url)) photos
from photos_staging ps 
where style_id > 3000000
and style_id <= 3500000
group by style_id
order by style_id;

INSERT INTO photos
select style_id, json_agg(json_build_object('thumbnail_url', thumbnail_url, 'url', url)) photos
from photos_staging ps 
where style_id > 3500000
and style_id <= 3800000
group by style_id
order by style_id;


INSERT INTO photos
select style_id, json_agg(json_build_object('thumbnail_url', thumbnail_url, 'url', url)) photos
from photos_staging ps 
where style_id > 3800000
and style_id <= 4200000
group by style_id
order by style_id;

INSERT INTO photos
select style_id, json_agg(json_build_object('thumbnail_url', thumbnail_url, 'url', url)) photos
from photos_staging ps 
where style_id > 4200000
and style_id <= 4700000
group by style_id
order by style_id;


-- select max(style_id) from photos; -- 4660354

-- DROP TABLE IF EXISTS PHOTOS_STAGING;

-- -- SQL Error [53100]: ERROR: could not write block 47872 of temporary file: No space left on device

-- select max(style_id) from photos;
-- select max(id) from styles_staging ss ;
-- select min(style_id) from photos_staging;

-- delete from photos_staging
-- where style_id <= 3000000;

ALTER TABLE styles_staging
  RENAME TO styles;
ALTER TABLE styles 
  ADD PRIMARY KEY (id);

ALTER TABLE styles 
ADD CONSTRAINT constraint_prod_fkey FOREIGN KEY (product_id) REFERENCES products (id);

ALTER TABLE photos 
ADD CONSTRAINT constraint_photos_fkey FOREIGN KEY (style_id) REFERENCES styles (id);

ALTER TABLE skus 
ADD CONSTRAINT constraint_skus_fkey FOREIGN KEY (style_id) REFERENCES styles (id);

-- QUERY FOR THE STYLES
select ss.id, ss.product_id, ss.name, ss.sale_price, ss.original_price, ss.default_style, sk.json_object_agg skus, p.photos 
from styles ss
left join skus sk on sk.style_id = ss.id 
left join photos p on p.style_id = ss.id 
where ss.product_id = 2;



-- JOINING THE STYLES AS ONE TABLE

create table styles_v2 as
select ss.id, ss.product_id, ss.name, ss.sale_price, ss.original_price, ss.default_style, sk.json_object_agg skus, p.photos 
from styles ss
left join skus sk on sk.style_id = ss.id 
left join photos p on p.style_id = ss.id 
where ss.product_id <= 100000;

insert into styles_v2
select ss.id, ss.product_id, ss.name, ss.sale_price, ss.original_price, ss.default_style, sk.json_object_agg skus, p.photos 
from styles ss
left join skus sk on sk.style_id = ss.id 
left join photos p on p.style_id = ss.id 
where ss.product_id > 100000
and ss.product_id <= 200000;

insert into styles_v2
select ss.id, ss.product_id, ss.name, ss.sale_price, ss.original_price, ss.default_style, sk.json_object_agg skus, p.photos 
from styles ss
left join skus sk on sk.style_id = ss.id 
left join photos p on p.style_id = ss.id 
where ss.product_id > 200000
and ss.product_id <= 300000;

insert into styles_v2
select ss.id, ss.product_id, ss.name, ss.sale_price, ss.original_price, ss.default_style, sk.json_object_agg skus, p.photos 
from styles ss
left join skus sk on sk.style_id = ss.id 
left join photos p on p.style_id = ss.id 
where ss.product_id > 300000
and ss.product_id <= 400000;

insert into styles_v2
select ss.id, ss.product_id, ss.name, ss.sale_price, ss.original_price, ss.default_style, sk.json_object_agg skus, p.photos 
from styles ss
left join skus sk on sk.style_id = ss.id 
left join photos p on p.style_id = ss.id 
where ss.product_id > 400000
and ss.product_id <= 500000;

insert into styles_v2
select ss.id, ss.product_id, ss.name, ss.sale_price, ss.original_price, ss.default_style, sk.json_object_agg skus, p.photos 
from styles ss
left join skus sk on sk.style_id = ss.id 
left join photos p on p.style_id = ss.id 
where ss.product_id > 500000
and ss.product_id <= 600000;

insert into styles_v2
select ss.id, ss.product_id, ss.name, ss.sale_price, ss.original_price, ss.default_style, sk.json_object_agg skus, p.photos 
from styles ss
left join skus sk on sk.style_id = ss.id 
left join photos p on p.style_id = ss.id 
where ss.product_id > 600000
and ss.product_id <= 700000;

insert into styles_v2
select ss.id, ss.product_id, ss.name, ss.sale_price, ss.original_price, ss.default_style, sk.json_object_agg skus, p.photos 
from styles ss
left join skus sk on sk.style_id = ss.id 
left join photos p on p.style_id = ss.id 
where ss.product_id > 700000
and ss.product_id <= 800000;

insert into styles_v2
select ss.id, ss.product_id, ss.name, ss.sale_price, ss.original_price, ss.default_style, sk.json_object_agg skus, p.photos 
from styles ss
left join skus sk on sk.style_id = ss.id 
left join photos p on p.style_id = ss.id 
where ss.product_id > 800000
and ss.product_id <= 900000;

insert into styles_v2
select ss.id, ss.product_id, ss.name, ss.sale_price, ss.original_price, ss.default_style, sk.json_object_agg skus, p.photos 
from styles ss
left join skus sk on sk.style_id = ss.id 
left join photos p on p.style_id = ss.id 
where ss.product_id > 900000
and ss.product_id <= 1000100;


ALTER TABLE styles_v2
ADD CONSTRAINT constraint_styles_fkey FOREIGN KEY (product_id) REFERENCES products (id);

ALTER TABLE styles
  RENAME TO styles_staging;

ALTER TABLE styles_v2
  RENAME TO styles; 

ALTER TABLE styles 
  ADD PRIMARY KEY (id);

CREATE INDEX idx_styles_prod_id 
ON styles(product_id);

ALTER TABLE related 
  ADD PRIMARY KEY (product_id);

update styles 
set skus = '{"null": null}'::json
where id = 7;


update styles 
set photos = '{"thumbnail_url": null,"url": null}'::json
where id in (32,14,17,15,33,19,21,26,28,25,18,24,23,9,34,22,35,31,29,36,27,20,8,13,30,7,10);



update styles 
set skus = '{"null": null}'::json
where id in (7, 47, 52, 48, 51, 9, 10, 50, 8,49);