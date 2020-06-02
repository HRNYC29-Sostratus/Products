// api.spec.js

const app = require('../server/server'); // Link to your server file
const supertest = require('supertest');
const request = supertest(app);

describe('Testing API', () => {
  it('tests our testing framework if it works', () => {
    expect(2).toBe(2);
  });
});

describe('Testing GET Product List API', () => {
  it('should call the endpoint with status of 200', async () => {
    const res = await request.get('/products/list').send();
    expect(res.statusCode).toEqual(200);
    expect(res.body[0].id).toBe(1);
  });
});

describe('Testing GET Product by ID API', () => {
  it('should call the endpoint with status of 200', async () => {
    const res = await request.get('/products/1').send();
    expect(res.statusCode).toEqual(200);
    expect(res.body.name).toBe('Camo Onesie');
  });
});

describe('Testing GET Styles by ID API', () => {
  it('should call the endpoint with status of 200', async () => {
    const res = await request.get('/products/1/styles').send();
    expect(res.statusCode).toEqual(200);
    expect(res.body.product_id).toBe('1');
  });
});

describe('Testing GET Related Products by ID API', () => {
  it('should call the endpoint with status of 200', async () => {
    const res = await request.get('/products/1/related').send();
    expect(res.statusCode).toEqual(200);
    expect(res.body[0]).toBe(2);
  });
});
