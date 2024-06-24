const express = require('express');
const cors = require('cors');
const bodyParser = require('body-parser');
const pool = require('../db');
require('dotenv').config();

const app = express();
app.use(cors());
app.use(bodyParser.json());

app.get('/products', async (req, res) => {
  try {
    const [rows] = await pool.query('SELECT * FROM products');
    res.json(rows);
  } catch (error) {
    console.error(error);
    res.status(500).send('Server Error');
  }
});

const PORT = process.env.PORT || 5000;
app.listen(PORT, () => console.log(`Server running on port ${PORT}`));
