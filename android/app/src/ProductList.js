// src/ProductList.js
import React, { useEffect, useState } from 'react';
import axios from 'axios';

const ProductList = () => {
  const [products, setProducts] = useState([]);

  useEffect(() => {
    const fetchData = async () => {
      const response1 = await axios.get('/api/products/page1');
      const response2 = await axios.get('/api/products/page2');
      const response3 = await axios.get('/api/products/page3');
      
      setProducts([...response1.data, ...response2.data, ...response3.data]);
    };

    fetchData();
  }, []);

  return (
    <div>
      <h1>Product List</h1>
      <ul>
        {products.map(product => (
          <li key={product.id}>{product.name} - {product.price}</li>
        ))}
      </ul>
    </div>
  );
};

export default ProductList;
