// api/index.js
const express = require('express');
const axios = require('axios');
const app = express();
const PORT = process.env.PORT || 5000;

app.get('/api/products/page1', async (req, res) => {
  try {
    const response = await axios.get('https://www.carrefour.com.ar/almacen');
    res.json(response.data);
  } catch (error) {
    res.status(500).send(error.message);
  }
});

app.get('/api/products/page2', async (req, res) => {
  try {
    const response = await axios.get('https://diaonline.supermercadosdia.com.ar/almacen');
    res.json(response.data);
  } catch (error) {
    res.status(500).send(error.message);
  }
});

app.get('/api/products/page3', async (req, res) => {
  try {
    const response = await axios.get('https://www.cotodigital3.com.ar/sitios/cdigi/browse/catalogo-almac%C3%A9n/_/N-8pub5zZ1uh5oniZyq0zf8/');
    res.json(response.data);
  } catch (error) {
    res.status(500).send(error.message);
  }
});

app.listen(PORT, () => {
  console.log(`Server running on port ${PORT}`);
});
